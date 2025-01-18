package llvm;

import llvm.Identifier;

typedef Function = {
	final name : String;
	final returnType : Type;
	final params : Array<Identifier>;
	final body : FunctionBody;
}