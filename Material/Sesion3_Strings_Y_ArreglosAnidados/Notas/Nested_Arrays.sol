// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

// Nested_Arrays o Arreglos Anidados

contract NestedArraysContract {

    function contieneTres(uint256[][] calldata nestedArray) 
        public 
        pure 
        returns (bool) {
            // [ [1,2], [7,4,3], [5,6,5,6,7] ]
            // [ [1,2], [7,4], [5,6] ]
            for (uint256 i = 0; i < nestedArray.length; i++) { 
                for (uint256 j = 0; j < nestedArray[i].length; j++) { //[3,4]
                    if (nestedArray[i][j] == 3) {
                        return true;
                        // regresa true sí el arreglo contiene un 3
                    }
                }
            }
            return false;
    }

// **************************************************************************

    // [[1,2],[3,4],[5,6]]
    function regresaElemento(uint256[][] calldata nestedArray) 
        public 
        pure 
        returns(uint256) {
            // regresa el cajon 2 con el elemento 1
            return nestedArray[2][1];
    }

        // [[1,2],[3,4],[5,6]]
    function regresaCajon(uint256[][] calldata nestedArray) 
        public 
        pure 
        returns(uint256[] memory) {
            // regresa el cajon 0 con todos sus elementos
            return nestedArray[0];
    }

    // [[1,2],[3,4],[5,6]]
    // Arreglo de tamaño fijo de 3 cajones y 2 elementos por cajon
    function regresaElemento2(uint256[2][3] calldata nestedArray) 
        public 
        pure 
        returns(uint256) {
            // regresa el cajon 1 con el elemento 0
            return nestedArray[1][0];
    }    
}
