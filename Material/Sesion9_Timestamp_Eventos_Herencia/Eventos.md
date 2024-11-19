# Emisión de Eventos

Técnicamente, nuestro token "ERC20" no cumple completamente con el estándar ERC20. Le falta una característica importante: los `eventos`.

Regla general: **Si una función causa un cambio de estado, debe ser registrada**.

¿Por qué registrar cosas? ¿No es cierto que la blockchain ya almacena inmutablemente cada transacción?

Eso es cierto. Pero registrar ciertos tipos de eventos nos ayuda a encontrar las transacciones que estamos buscando de manera mucho más rápida y organizada.

Así es como tu billetera de criptomonedas puede descubrir rápidamente tu saldo de tokens ERC20. Sería muy molesto tener que buscar en cada transacción que haya ocurrido en un token ERC20 para descubrir si posees alguno. Sin embargo, los logs se almacenan de manera que esta recuperación sea eficiente.

**Los eventos no pueden ser vistos por otros contratos inteligentes. Están optimizados para ser consultados fuera de la blockchain.**

```solidity
contract Events01 {
    event Deposit(address indexed depositor, uint256 amount);

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}
```

Un evento puede tener hasta 3 tipos indexados, pero no hay un límite estricto en el número de parámetros no indexados.

Por cierto, los nombres de los argumentos después del tipo de dato son opcionales. Podríamos haber escrito el evento anterior como:

```solidity
event Deposit(address indexed, uint256);
```

¿Cuándo debería una variable ser indexada o no? Si podrías estar interesado en encontrar ese valor rápidamente, como _"¿ha estado una dirección involucrada con este contrato de tokens?"_, entonces deberías indexarla. Probablemente no te interese buscar si este contrato ha recibido exactamente "x" cantidad de tokens, por lo que no indexamos el monto.

Y finalmente, aquí está nuestro token ERC-20 con eventos:

```solidity
// SPDX-License-Identifier: MIT
// Versión final de nuestro Token ERC-20
pragma solidity ^0.8.0;

contract ERC20 {
    string public name;
    string public symbol;
    mapping(address => uint256) public balanceOf;
    address public owner;
    uint8 public decimals;
    uint256 public totalSupply;

    // owner -> spender -> allowance
    // esto permite que un propietario otorgue permisos a múltiples direcciones
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        decimals = 18;

        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(msg.sender == owner, "only owner can create tokens");
        totalSupply += amount;
        balanceOf[owner] += amount;

        emit Transfer(address(0), owner, amount);
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        return helperTransfer(msg.sender, to, amount);
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        if (msg.sender != from) {
            require(
                allowance[from][msg.sender] >= amount,
                "not enough allowance"
            );

            allowance[from][msg.sender] -= amount;
        }

        return helperTransfer(from, to, amount);
    }

    function helperTransfer(address from, address to, uint256 amount) internal returns (bool) {
        require(balanceOf[from] >= amount, "not enough money");
        require(to != address(0), "cannot send to address(0)");
        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        emit Transfer(from, to, amount);
        return true;
    }
}
```
