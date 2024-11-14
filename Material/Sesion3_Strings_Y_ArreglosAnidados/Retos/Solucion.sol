// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/*
Escribe una funcion que se llame regresaCadena() y dentro de la funcion:
 - Declara un arreglo de tamaño fijo donde guardes -> [["Hola"],["Adios"]]
 - Retorna "Adios"
*/
contract Cadenas{
    function regresaCadena() public pure returns (string memory){
        string [1][2] memory  elemento = [["Hola"],["Adios"]];
        return elemento[1][0];
    }    
}