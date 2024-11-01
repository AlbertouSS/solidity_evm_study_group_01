// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Un mapping es como una cajonera organizada por nombres (llaves/claves) en lugar de posiciones (como los arreglos)

contract EjemploContrato {

    // Creamos un mapping público que asocia numeros con numeros
    mapping(uint256 => uint256) public miMapping;

    function setMapping(uint256 llave, uint256 valor) 
        public {
            // agregamos una nueva llave (un número) al mapping con su respectivo valor (otro número)
            // por ejemplo  miMapping[1] = 200
            miMapping[llave] = valor;
            
    }

    function getValue(uint256 key) 
        public 
        view 
        returns (uint256) {
            // leemos el valor correspondiente a la llave que querramos
            return miMapping[key];
    }

    /*Qué pasa sí queremos acceder a un mappiing con una llave que no existe*/

    //  regresaría false
    mapping(uint256 => bool) public mapaABoleano;

    //  regresaría 0
    mapping(uint256 => uint256) public mapaAEntero; 

    //  regresaria 0x0000000000000000000000000000000000000000 
    mapping(uint256 => address) public mapaADireccion;

    //  regresaria "" (una cadena vacia)
    mapping(uint256 => string) public mapaACadena;
}