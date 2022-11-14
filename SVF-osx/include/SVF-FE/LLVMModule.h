//===- LLVMModule.h -- LLVM Module class-----------------------------------------//
//
//                     SVF: Static Value-Flow Analysis
//
// Copyright (C) <2013->  <Yulei Sui>
//

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//===----------------------------------------------------------------------===//

/*
 * LLVMModule.h
 *
 *  Created on: 23 Mar.2020
 *      Author: Yulei Sui
 */

#ifndef INCLUDE_SVF_FE_LLVMMODULE_H_
#define INCLUDE_SVF_FE_LLVMMODULE_H_

#include "SVF-FE/BasicTypes.h"
#include "SVF-FE/CPPUtil.h"
#include "Util/BasicTypes.h"
#include "Util/SVFModule.h"

namespace SVF
{

class LLVMModuleSet
{
public:

    typedef std::vector<const Function*> FunctionSetType;
    typedef Map<const Function*, const Function*> FunDeclToDefMapTy;
    typedef Map<const Function*, FunctionSetType> FunDefToDeclsMapTy;
    typedef Map<const GlobalVariable*, GlobalVariable*> GlobalDefToRepMapTy;

    typedef Map<const Function*, SVFFunction*> LLVMFun2SVFFunMap;
    typedef Map<const BasicBlock*, SVFBasicBlock*> LLVMBB2SVFBBMap;
    typedef Map<const Instruction*, SVFInstruction*> LLVMInst2SVFInstMap;
    typedef Map<const GlobalValue*, SVFGlobalValue*> LLVMGlobal2SVFGlobalMap;
    typedef Map<const Argument*, SVFArgument*> LLVMArgument2SVFArgumentMap;
    typedef Map<const ConstantData*, SVFConstantData*> LLVMConstData2SVFConstDataMap;
    typedef Map<const Value*, SVFOtherValue*> LLVMValue2SVFOtherValueMap;

private:
    static LLVMModuleSet* llvmModuleSet;
    SVFModule* svfModule;
    std::unique_ptr<LLVMContext> cxts;
    std::vector<std::unique_ptr<Module>> owned_modules;
    std::vector<std::reference_wrapper<Module>> modules;

    /// Function declaration to function definition map
    FunDeclToDefMapTy FunDeclToDefMap;
    /// Function definition to function declaration map
    FunDefToDeclsMapTy FunDefToDeclsMap;
    /// Global definition to a rep definition map
    GlobalDefToRepMapTy GlobalDefToRepMap;

    LLVMFun2SVFFunMap LLVMFunc2SVFFunc; ///< Map an LLVM Function to an SVF Function
    LLVMBB2SVFBBMap LLVMBB2SVFBB;
    LLVMInst2SVFInstMap LLVMInst2SVFInst;
    LLVMArgument2SVFArgumentMap LLVMArgument2SVFArgument;
    LLVMGlobal2SVFGlobalMap LLVMGlobal2SVFGlobal;
    LLVMConstData2SVFConstDataMap LLVMConstData2SVFConstData;
    LLVMValue2SVFOtherValueMap LLVMValue2SVFOtherValue;

    /// Constructor
    LLVMModuleSet(): svfModule(nullptr), cxts(nullptr), preProcessed(false) {}

    void build();

public:
    static inline LLVMModuleSet* getLLVMModuleSet()
    {
        if (llvmModuleSet == nullptr)
            llvmModuleSet = new LLVMModuleSet();
        return llvmModuleSet;
    }

    static void releaseLLVMModuleSet()
    {
        if (llvmModuleSet)
            delete llvmModuleSet;
        llvmModuleSet = nullptr;
    }

    SVFModule* buildSVFModule(Module& mod);
    SVFModule* buildSVFModule(const std::vector<std::string>& moduleNameVec);

    inline SVFModule* getSVFModule()
    {
        assert(svfModule && "svfModule has not been built yet!");
        return svfModule;
    }

    void preProcessBCs(std::vector<std::string>& moduleNameVec);

    u32_t getModuleNum() const
    {
        return modules.size();
    }

    const std::vector<std::reference_wrapper<Module>>& getLLVMModules() const
    {
        return modules;
    }

    Module *getModule(u32_t idx) const
    {
        return &getModuleRef(idx);
    }

    Module &getModuleRef(u32_t idx) const
    {
        assert(idx < getModuleNum() && "Out of range.");
        return modules[idx];
    }

    // Dump modules to files
    void dumpModulesToFile(const std::string suffix);

    inline void addFunctionMap(const Function* func, SVFFunction* svfFunc)
    {
        LLVMFunc2SVFFunc[func] = svfFunc;
        setValueAttr(func,svfFunc);
    }
    inline void addBasicBlockMap(const BasicBlock* bb, SVFBasicBlock* svfBB)
    {
        LLVMBB2SVFBB[bb] = svfBB;
        setValueAttr(bb,svfBB);
    }
    inline void addInstructionMap(const Instruction* inst, SVFInstruction* svfInst)
    {
        LLVMInst2SVFInst[inst] = svfInst;
        setValueAttr(inst,svfInst);
    }
    inline void addArgumentMap(const Argument* arg, SVFArgument* svfArg)
    {
        LLVMArgument2SVFArgument[arg] = svfArg;
        setValueAttr(arg,svfArg);
    }
    inline void addGlobalValueMap(const GlobalValue* glob, SVFGlobalValue* svfglob)
    {
        LLVMGlobal2SVFGlobal[glob] = svfglob;
        setValueAttr(glob,svfglob);
    }
    inline void addConstantDataMap(const ConstantData* cd, SVFConstantData* svfcd)
    {
        LLVMConstData2SVFConstData[cd] = svfcd;
        setValueAttr(cd,svfcd);
    }
    inline void addOtherValueMap(const Value* ov, SVFOtherValue* svfov)
    {
        LLVMValue2SVFOtherValue[ov] = svfov;
        setValueAttr(ov,svfov);
    }

    SVFValue* getSVFValue(const Value* value);

    inline SVFFunction* getSVFFunction(const Function* fun) const
    {
        LLVMFun2SVFFunMap::const_iterator it = LLVMFunc2SVFFunc.find(fun);
        assert(it!=LLVMFunc2SVFFunc.end() && "SVF Function not found!");
        return it->second;
    }

    inline SVFBasicBlock* getSVFBasicBlock(const BasicBlock* bb) const
    {
        LLVMBB2SVFBBMap::const_iterator it = LLVMBB2SVFBB.find(bb);
        assert(it!=LLVMBB2SVFBB.end() && "SVF BasicBlock not found!");
        return it->second;
    }

    inline SVFInstruction* getSVFInstruction(const Instruction* inst) const
    {
        LLVMInst2SVFInstMap::const_iterator it = LLVMInst2SVFInst.find(inst);
        assert(it!=LLVMInst2SVFInst.end() && "SVF Instruction not found!");
        return it->second;
    }

    inline SVFArgument* getSVFArgument(const Argument* arg) const
    {
        LLVMArgument2SVFArgumentMap::const_iterator it = LLVMArgument2SVFArgument.find(arg);
        assert(it!=LLVMArgument2SVFArgument.end() && "SVF Argument not found!");
        return it->second;
    }

    inline SVFGlobalValue* getSVFGlobalValue(const GlobalValue* g) const
    {
        LLVMGlobal2SVFGlobalMap::const_iterator it = LLVMGlobal2SVFGlobal.find(g);
        assert(it!=LLVMGlobal2SVFGlobal.end() && "SVF Global not found!");
        return it->second;
    }

    SVFConstantData* getSVFConstantData(const ConstantData* cd);

    SVFOtherValue* getSVFOtherValue(const Value* ov);

    /// Get the corresponding Function based on its name
    inline const SVFFunction* getSVFFunction(std::string name)
    {
        Function* fun = nullptr;

        for (u32_t i = 0; i < llvmModuleSet->getModuleNum(); ++i)
        {
            Module* mod = llvmModuleSet->getModule(i);
            fun = mod->getFunction(name);
            if (fun)
            {
                return llvmModuleSet->getSVFFunction(fun);
            }
        }
        return nullptr;
    }

    bool hasDefinition(const Function* fun) const
    {
        assert(fun->isDeclaration() && "not a function declaration?");
        FunDeclToDefMapTy::const_iterator it = FunDeclToDefMap.find(fun);
        return it != FunDeclToDefMap.end();
    }

    const Function* getDefinition(const Function* fun) const
    {
        assert(fun->isDeclaration() && "not a function declaration?");
        FunDeclToDefMapTy::const_iterator it = FunDeclToDefMap.find(fun);
        assert(it != FunDeclToDefMap.end() && "has no definition?");
        return it->second;
    }

    bool hasDeclaration(const Function* fun) const
    {
        if(fun->isDeclaration() && !hasDefinition(fun))
            return false;

        const Function* funDef = fun;
        if(fun->isDeclaration() && hasDefinition(fun))
            funDef = getDefinition(fun);

        FunDefToDeclsMapTy::const_iterator it = FunDefToDeclsMap.find(funDef);
        return it != FunDefToDeclsMap.end();
    }

    const FunctionSetType& getDeclaration(const Function* fun) const
    {
        const Function* funDef = fun;
        if(fun->isDeclaration() && hasDefinition(fun))
            funDef = getDefinition(fun);

        FunDefToDeclsMapTy::const_iterator it = FunDefToDeclsMap.find(funDef);
        assert(it != FunDefToDeclsMap.end() && "does not have a function definition (body)?");
        return it->second;
    }

    /// Global to rep
    bool hasGlobalRep(const GlobalVariable* val) const
    {
        GlobalDefToRepMapTy::const_iterator it = GlobalDefToRepMap.find(val);
        return it != GlobalDefToRepMap.end();
    }

    GlobalVariable *getGlobalRep(const GlobalVariable* val) const
    {
        GlobalDefToRepMapTy::const_iterator it = GlobalDefToRepMap.find(val);
        assert(it != GlobalDefToRepMap.end() && "has no rep?");
        return it->second;
    }


    Module* getMainLLVMModule() const
    {
        return getModule(0);
    }

    LLVMContext& getContext() const
    {
        assert(!empty() && "empty LLVM module!!");
        return getMainLLVMModule()->getContext();
    }

    bool empty() const
    {
        return getModuleNum() == 0;
    }

private:
    std::vector<const Function*> getLLVMGlobalFunctions(const GlobalVariable* global);

    void loadModules(const std::vector<std::string>& moduleNameVec);
    void addSVFMain();

    void createSVFDataStructure();
    void initSVFFunction();
    void initSVFBasicBlock(const SVFFunction* func);
    void initDomTree(const SVFFunction* func);
    void setValueAttr(const Value* val, SVFValue* value);
    void buildFunToFunMap();
    void buildGlobalDefToRepMap();
    /// Invoke llvm passes to modify module
    void prePassSchedule();
    bool preProcessed;
};

} // End namespace SVF

#endif /* INCLUDE_SVF_FE_LLVMMODULE_H_ */