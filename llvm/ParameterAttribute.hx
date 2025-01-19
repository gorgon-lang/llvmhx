package llvm;

import llvm.Type.TypeUtil;

@:forward
enum abstract TestMask(Int) from Int to Int {
	final Snan = 1;
	final Qnan = 2;
	final Nan = 3;
	final Ninf = 4;
	final Nnorm = 8;
	final Nsub = 16;
	final Nzero = 32;
	final Pzero = 64;
	final Zero = 96;
	final Psub = 128;
	final Sub = 144;
	final Pnorm = 256;
	final Norm = 264;
	final Pinf = 512;
	final Inf = 516;
	final All = 1023;
}

enum ParameterAttribute {
	ZeroExt;
	SignExt;
	NoExt;
	InReg;
	ByVal(type:Type);
	ByRef(type:Type);
	Preallocated(type:Type);
	InAlloca(type:Type);
	SRet(type:Type);
	ElementType(type:Type);
	Alignment(n:Int);
	NoAlias;
	// TODO: handle Captures
	NoCapture;
	NoFree;
	Nest;
	Returned;
	NonNull;
	Dereferenceable(n:Int);
	DereferenceableOrNull(n:Int);
	SwiftSelf;
	SwiftAsync;
	SwiftError;
	Immarg;
	NoUndef;
	NoFPClass(testMask:TestMask);
	AlignStack(n:Int);
	AllocAlign;
	AllocPtr;
	ReadNone;
	ReadOnly;
	WriteOnly;
	Writeable;
	Initializes; // TODO
	DeadOnUnwind;
	Range(type:Type, a:Int, b:Int);
}

class ParameterAttributeTool {
	public static function toString(p:ParameterAttribute) {
		switch p {
			case ZeroExt: return "zeroext";
			case SignExt: return "signext";
			case NoExt: return "noext";
			case InReg: return "inreg";
			case ByVal(ty): return 'byval(${TypeUtil.toString(ty)})';
			case ByRef(ty): return 'byref(${TypeUtil.toString(ty)})';
			case Preallocated(_): return "preallocated";
			case InAlloca(_): return "inalloca";
			case SRet(_): return "sret";
			case ElementType(_): return "elementtype";
			case Alignment(_): return "alignment";
			case NoAlias: return "noalias";
			case NoCapture: return "nocapture";
			case NoFree: return "nofree";
			case Nest: return "nest";
			case Returned: return "returned";
			case NonNull: return "nonnull";
			case Dereferenceable(_): return "dereferenceable";
			case DereferenceableOrNull(_): return "dereferenceableornull";
			case SwiftSelf: return "swiftself";
			case SwiftAsync: return "swiftasync";
			case SwiftError: return "swifterror";
			case Immarg: return "immarg";
			case NoUndef: return "noundef";
			case NoFPClass(_): return "nofpclass";
			case AlignStack(_): return "alignstack";
			case AllocAlign: return "allocalign";
			case AllocPtr: return "allocptr";
			case ReadNone: return "readnone";
			case ReadOnly: return "readonly";
			case WriteOnly: return "writeonly";
			case Writeable: return "writeable";
			case Initializes: return "initializes";
			case DeadOnUnwind: return "deadonunwind";
			case Range(_, _, _): return "range";
		}
	}
}