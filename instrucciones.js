
/**
 * Esta función se encarga de crear objetos tipo Temporal.
 * @param {*} codigo 
 * @param {*} temporal 
 */
function temporal() {
	return {
		codigo: "",
		temporal: ""
	}
}


/**
 * El objetivo de esta API es proveer las funciones necesarias para la construcción de Temporales.
 */
const instruccionesAPI = {

	/**
	 * Crea un nuevo objeto tipo Temporal.
	 */
	nuevoTemporal: function() {
		return temporal();
	},

	/**
	 * Crea un nuevo objeto tipo Temporal, asignandole su respectivo nombreS.
	 * @param {*} nombreTemporal 
	 */
	nuevoTemp: function(nombreTemporal) {
		tmp = new temporal();
		tmp.temporal = nombreTemporal;
		return tmp;
	}
	
}

// Exportamos nuestras constantes y nuestra API

module.exports.instruccionesAPI = instruccionesAPI;