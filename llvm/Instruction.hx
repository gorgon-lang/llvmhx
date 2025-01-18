package llvm;

import llvm.Identifier;

enum Instruction {
	Ret(operand:Operand);
	Br(dest:Identifier, cond:Operand, iftrue:Identifier, iffalse:Identifier);
	Add(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool, ?nsw:Bool);
	Fadd(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag);
	Sub(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool, ?nsw:Bool);
	FSub(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag);
	Mul(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool, ?nsw:Bool);
	FMul(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag);
	UDiv(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool);
	SDiv(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool);
	FDiv(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag);
}