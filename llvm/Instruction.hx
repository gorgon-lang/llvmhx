package llvm;

import llvm.CallingConventions;
import llvm.Parameter;
import llvm.Constant;
import llvm.ParameterAttribute;
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
	URem(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand);
	SRem(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand);
	FRem(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?fmflags:FastMathFlag);
	Shl(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?nuw:Bool, ?nsw:Bool);
	LShr(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool);
	AShr(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand, ?exact:Bool);
	And(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand);
	Or(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand);
	Xor(res:Identifier, resultType:Type, lhs:Operand, rhs:Operand);

	Alloca(res:Identifier, type:Type, inalloca:Bool, ?alignment:Int, ?addrspace:Int, ?numElements:Constant);

	Call(functionDef:Function, args:Array<Parameter>, ?res:Identifier, ?resultType:Type, ?tail:CallTail, ?fmflags:FastMathFlag, ?retAttr:Array<ParameterAttribute>, ?addrspace:Int, ?fnAttrs:Array<FunctionAttribute>, ?cconv:CallingConventions);
}