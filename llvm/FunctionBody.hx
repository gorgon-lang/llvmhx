package llvm;

import llvm.Instruction;

typedef FunctionBody = Array<FunctionBodyElements>;

enum FunctionBodyElements {
	Label(name:String, instructions:Array<Instruction>);
	Instruction(instruction:Instruction);
}