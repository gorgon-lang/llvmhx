package llvm;

enum ThreadLocalStorage {
	GeneralDynamic;
	LocalDynamic;
	InitialExec;
	LocalExec;
}

class ThreadLocalStorageUtil {
	public static inline function toString(v:ThreadLocalStorage) {
		switch v {
			case GeneralDynamic: return "";
			case LocalDynamic: return "localdynamic";
			case InitialExec: return "initialexec";
			case LocalExec: return "localexec";
		}
	}
}