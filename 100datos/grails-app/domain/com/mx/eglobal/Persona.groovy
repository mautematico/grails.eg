package com.mx.eglobal

class Persona {
	String nombre;
	Integer	edad;
	String iban;

    static constraints = {
    }


	static mapping = {
		//    autoImport true
    	    table "datos"
	            version false
//	            id column: "primary_key_column"
	            nombre column: "nombre"
	            edad column: "edad"
	            iban column: "iban"
	}
}
