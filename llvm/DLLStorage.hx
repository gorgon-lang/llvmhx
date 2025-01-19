package llvm;

enum DLLStorage {
	DLLImport;
	DLLExport;	
}

class DLLStorageUtil {
	public static inline function toString(v:DLLStorage) {
		switch v {
			case DLLImport: return "dllimport";
			case DLLExport: return "dllexport";
		}
	}
}