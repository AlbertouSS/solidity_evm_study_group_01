// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;

/* NOTA
Este contrato de ejemplo tiene una falla de seguridad ya que cualquiera puede
a) Asignarse cualquier cantidad de tokens cuando quiera 
b) Cualquiera puede transerir tokens de una wallet a otra sin ser dueños de la misma

Para fines de explicar los mappings, el contrato quedará así y se mejorará en ejemplos posteriores
*/

/*
PARTICULARIDADES DE LOS MAPPINGS
a) Solo pueden declararse como variables de estado (fuera de funciones)
b) No pueden iterarse como los arreglos
c) No pueden retornarse
*/

contract TokenERC20 {

    // mapping declarado como variable de estado
    mapping(address => uint256) public balances;

    function asignarBalance(address usuario, uint256 cantidad) 
        public {
            balances[usuario] = cantidad;
    }

    function transferirTokensEntreUsuarios(
            address remitente, 
            address destinatario, 
            uint256 cantidad) 
        public {
            balances[remitente] -= cantidad;   // deduct/debit the sender's balance
            balances[destinatario] += cantidad; // credit the reciever's balance
    }
}