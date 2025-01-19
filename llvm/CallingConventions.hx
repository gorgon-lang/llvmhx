package llvm;

@:forward
enum abstract BaseCallingConventions(String) from String to String {
	final C = "ccc";
	final Fast = "fastcc";
	final Cold = "coldcc";
	final GHC = "ghccc";
	final HiPE = "cc 11";
	final Anyreg = "anyregcc";
	final PreserveMost = "preserve_mostcc";
	final PreserveAll = "preserve_allcc";
	final PreserveNone = "preserve_nonecc";
	final CXXFastTLS = "cxx_fast_tlscc";
	final TailCC = "tailcc";
	final Swift = "swiftcc";
	final SwiftTail = "swifttailcc";
	final WindowsControlFlow = "cfguard_checkcc";
}

enum CallingConventions {
	Base(cc:BaseCallingConventions);
	Cc(n:Int);
}

class CallingConventionTool {
	public static function toString(cc:CallingConventions):String {
		switch(cc) {
			case Base(cc): return cc;
			case Cc(n): return "cc " + n;
		}
	}
}