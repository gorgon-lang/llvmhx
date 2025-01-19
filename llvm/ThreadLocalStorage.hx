package llvm;

enum ThreadLocalStorage {
	GeneralDynamic;
	LocalDynamic;
	InitialExec;
	LocalExec;
}

class ThreadLocalStorageUtil {
	public inline function toString(v:ThreadLocalStorage) {
		switch v {
			case GeneralDynamic: return "general_dynamic";
			case LocalDynamic: return "local_dynamic";
			case InitialExec: return "initial_exec";
			case LocalExec: return "local_exec";
		}
	}
}