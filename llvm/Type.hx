package llvm;

enum Type {
	TVoid;
	TInt(n:Int);
	THalf;
	TBFloat;
	TFloat;
	TDouble;
	TFp128;
	TX86Fp80;
	TPPCFp128;

	TArray(n:Int, t:Type);
	TStruct(t:Array<Type>);
	TLabel;
}

class TypeUtil {
	public static function toString(t:Type):String {
		switch(t) {
			case TVoid: return 'void';
			case TInt(n): return 'i${n}';
			case THalf: return 'half';
			case TBFloat: return 'bfloat';
			case TFloat: return 'float';
			case TDouble: return 'double';
			case TFp128: return 'fp128';
			case TX86Fp80: return 'x86_fp80';
			case TPPCFp128: return 'ppc_fp128';
			case TArray(n, t): return '[${n} x ${TypeUtil.toString(t)}]';
			case TStruct(t): return 'type {${t.map(TypeUtil.toString).join(', ')}}';
			case TLabel: return 'label';
		}
	}
}