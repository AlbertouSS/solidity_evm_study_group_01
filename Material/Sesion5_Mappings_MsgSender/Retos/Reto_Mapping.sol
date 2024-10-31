// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

contract NumerosEspeciales {
    mapping(uint256 => bool) public esEspecial;

    /**
     * Guarda en un mapping sí un múmero es especial o no (usando boleanos)
     */

    // Haz que los numeros sean especiales
    function hacerNumeroEspecial(uint256 n) public {
        // escribe tu cógido aquí
        esEspecial[n] = true;
    }

    // Haz que los numeros NO sean especiales
    function hacerNumeroNoEspecial(uint256 n) public {
        // escribe tu cógido aquí
        esEspecial[n] = false;
    }

    /// regresa sí un número es especial o no
    function elNumeroEsEspecial(uint256 n) public view returns (bool) {
        // escribe tu cógido aquí
        if(esEspecial[n]){
        // esto es lo mismo -> if(esEspecial[n]==true)
            return true;
        }
        return false;
    }        
}