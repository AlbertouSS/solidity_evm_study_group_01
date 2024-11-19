# Herencia

Implementar un contrato ERC20 desde cero cada vez sin duda sería agotador. Solidity se comporta como un lenguaje orientado a objetos y permite la herencia. Aquí tienes un ejemplo mínimo:

```solidity
contract Parent {
    function theMeaningOfLife() public pure returns (uint256) {
        return 42;
    }
}

contract Child is Parent {

}
```

Usamos la palabra clave `is` para indicar que `Child` hereda funcionalidad de `Parent`.

Como en otros lenguajes orientados a objetos, las funciones pueden ser sobrescritas:

```solidity
contract Parent {
    function theMeaningOfLife() public pure virtual returns (uint256) {
        return 42;
    }
}

contract Child is Parent {
    function theMeaningOfLife() public pure override returns (uint256) {
        return 3;
    }
}
```

Nota que hemos introducido estas dos palabras clave: `virtual` y `override`.

De la [documentación](https://docs.soliditylang.org/en/v0.8.28/cheatsheet.html):

- `virtual` es para funciones y modificadores: Permite que el comportamiento de la función o modificador sea cambiado en contratos derivados.
- `override`: Declara que esta función, modificador o variable de estado pública cambia el comportamiento de una función o modificador en un contrato base.

Además, cuando una función es sobrescrita, **debe coincidir exactamente en nombre, argumentos y tipo de retorno**.

### Herencia múltiple

Puedes hacer herencia múltiple:

```solidity
contract Child is Parent1, Parent2 {

}
```

Si los dos contratos padres tienen una función con el mismo nombre, el contrato hijo debe sobrescribirla o el comportamiento será ambiguo. Si te encuentras en esta situación, probablemente hayas cometido un error en el diseño del software.

### Private vs Internal

Hay dos maneras de hacer que una función no sea accesible desde el mundo exterior: asignarles un modificador `private` o `internal`. La distinción es simple.

Las funciones (y variables) privadas no pueden ser _vistas_ por los contratos hijos.

Las funciones y variables internas sí pueden serlo.
