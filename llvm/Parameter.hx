package llvm;

import llvm.Type.TypeUtil;
import llvm.ParameterAttribute;

typedef ParameterType = {
	final type:Type;
	final ?name:String;
	var ?attributes:Array<ParameterAttribute>;
}

@:structInit
@:forward
abstract Parameter(ParameterType) from ParameterType to ParameterType {
	public function new(def:ParameterType) {
		this = def;
	}

	public function toString() {
		final buffer : StringBuf = new StringBuf();
		buffer.add(TypeUtil.toString(this.type));
		if(this.name != null) {
			buffer.add(' ${this.name}');
		}
		if(this.attributes != null) {
			for(attr in this.attributes) {
				buffer.add(' ${ParameterAttributeTool.toString(attr)}');
			}
		}
		return buffer.toString();
	}

	public function toUnnamedString() {
		final buffer : StringBuf = new StringBuf();
		buffer.add(TypeUtil.toString(this.type));
		if(this.attributes != null) {
			for(attr in this.attributes) {
				buffer.add(' ${ParameterAttributeTool.toString(attr)}');
			}
		}
		return buffer.toString();
	}
}