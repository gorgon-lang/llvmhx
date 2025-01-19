package llvm;

import llvm.Constant;
import llvm.UnnamedAddressSpace.UnnamedAddressSpaceUtil;
import llvm.Type.TypeUtil;
import llvm.ThreadLocalStorage;
import llvm.DLLStorage;
import llvm.Visibility;
import llvm.RuntimePreemption;
import llvm.LinkageType;

enum GlobalType {
	Global;
	Constant;
}

typedef GlobalVarDef = {
	final name : String;
	var type : Type;
	var ?initConstant : Constant;
	var ?linkage : LinkageType;
	var ?preemption : RuntimePreemption;
	var ?visibility : Visibility;
	var ?dllStorageClass : DLLStorage;
	var ?threadLocal : ThreadLocalStorage;
	var ?unnamedAddr : UnnamedAddressSpace;
	var ?addrSpace : Int;
	var ?externallyInitialized : Bool;
	var ?global:GlobalType;
	var ?section : String;
	var ?partition : String;
	var ?comdat : String;
	var ?alignment : Int;
	var ?code_model : String;
	var ?no_sanitize_address:Bool;
	var ?no_sanitize_hwaddress:Bool;
	var ?sanitize_address_dyninit : Bool;
	var ?sanitize_memtag : Bool;
}

@:forward
abstract GlobalVar(GlobalVarDef) from GlobalVarDef to GlobalVarDef {
	public function new(def:GlobalVarDef) {
		if(!Identifier.UNNAMED_VALIDATOR.match(def.name)) {
			throw new haxe.Exception('Invalid identifier ${def.name}');
		}

		if(def.externallyInitialized == null) {
			def.externallyInitialized = false;
		}
		if(def.no_sanitize_address == null) {
			def.no_sanitize_address = false;
		}
		if(def.no_sanitize_hwaddress == null) {
			def.no_sanitize_hwaddress = false;
		}
		if(def.sanitize_address_dyninit == null) {
			def.sanitize_address_dyninit = false;
		}
		if(def.sanitize_memtag == null) {
			def.sanitize_memtag = false;
		}

		this = def;
	}

	public function getPtr() : String {
		return 'ptr @${this.name}';
	}

	public function setLinkage(linkage:LinkageType):GlobalVar {
		this.linkage = linkage;
		return this;
	}

	public function setPreemption(preemption:RuntimePreemption):GlobalVar {
		this.preemption = preemption;
		return this;
	}

	public function setVisibility(visibility:Visibility):GlobalVar {
		this.visibility = visibility;
		return this;
	}

	public function toString():String {
		final buffer : StringBuf = new StringBuf();
		buffer.add('@${this.name} = ');

		if (this.linkage != null) {
			buffer.add('${LinkageTypeUtil.toString(this.linkage)} ');
		}

		if(this.preemption != null) {
			buffer.add('${RuntimePreemptionUtil.toString(this.preemption)} ');
		}

		if(this.visibility != null) {
			buffer.add('${VisibilityUtil.toString(this.visibility)} ');
		}

		if(this.dllStorageClass != null) {
			buffer.add('${DLLStorageUtil.toString(this.dllStorageClass)} ');
		}

		if(this.threadLocal != null) {
			buffer.add('thread_local(${ThreadLocalStorageUtil.toString(this.threadLocal)}) ');
		}

		if(this.unnamedAddr != null) {
			buffer.add('${UnnamedAddressSpaceUtil.toString(this.unnamedAddr)} ');
		}

		if(this.addrSpace != null) {
			buffer.add('addrspace(${this.addrSpace}) ');
		}

		if(this.externallyInitialized) {
			buffer.add('externally_initialized ');
		}

		if(this.global != null) {
			switch this.global {
				case GlobalType.Global: buffer.add('global ');
				case GlobalType.Constant: buffer.add('constant ');
			}
		}

		buffer.add('${TypeUtil.toString(this.type)} ');

		if(this.initConstant != null) {
			buffer.add('${this.initConstant.toString()}');
		}

		if(this.section != null) {
			buffer.add(', section "${this.section}" ');
		}

		if(this.partition != null) {
			buffer.add(', partition "${this.partition}" ');
		}

		if(this.comdat != null) {
			buffer.add(', comdat "${this.comdat}" ');
		}

		if(this.alignment != null) {
			buffer.add(', align ${this.alignment} ');
		}

		if(this.code_model != null) {
			buffer.add(', code_model "${this.code_model}" ');
		}

		if(this.no_sanitize_address) {
			buffer.add(', no_sanitize_address ');
		}

		if(this.no_sanitize_hwaddress) {
			buffer.add(', no_sanitize_hwaddress ');
		}

		if(this.sanitize_address_dyninit) {
			buffer.add(', sanitize_address_dyninit ');
		}

		if(this.sanitize_memtag) {
			buffer.add(', sanitize_memtag ');
		}
		return buffer.toString();
	}
}