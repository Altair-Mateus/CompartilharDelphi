# TComboBoxHelper

`TComboBoxHelper` é uma extensão simples, leve e reutilizável para o componente `TComboBox` do Delphi.

Ele centraliza funcionalidades comuns e recorrentes, reduzindo duplicação de código e tornando o uso do componente muito mais simples.

---

# Funcionalidades

## Ajuste Automático da Largura do DropDown

**Método:** `AdjustDropDownWidth`

Expande automaticamente a largura do DropDown para que nenhum item fique cortado.

**Recomendado:** chamar no evento `OnDropDown`.

---

## Exibição Automática de Hint

**Método:** `ShowTextHint`

Exibe automaticamente um Hint com o texto atual do ComboBox.

**Recomendado:** chamar no evento `OnMouseEnter`.

---

## Carregamento de Itens

**Método:** `LoadFromStrings`

Permite preencher o ComboBox utilizando:

- `array of string`;
- `TStrings`;
- Item padrão opcional;
- Seleção automática do item padrão.

---

# Suporte a Enumeradores (NOVO)

Agora o `TComboBoxHelper` também oferece suporte nativo para trabalhar com **Enums**, eliminando conversões manuais entre `ItemIndex`, `Integer` e `TObject`.

## Métodos

### TryGetEnum<T>

Obtém o enumerador atualmente selecionado no ComboBox.

```pascal
function TryGetEnum<T>(out Value: T): Boolean;
```

Retorna `True` quando um valor válido foi encontrado.

---

### TrySetEnum<T>

Seleciona automaticamente o item correspondente ao Enum informado.

```pascal
function TrySetEnum<T>(const Value: T): Boolean;
```

Retorna `True` quando encontrou o Enum dentro da lista.

---

# Exemplo de Utilização

## Enum

```pascal
type
  TTipoUsuario = (
    tpuNaoIdentificado,
    tpuBalcao,
    tpuEscritorio,
    tpuGerente,
    tpuAdministrador
  );
```

## Helper do Enum

```pascal
type
  TTipoUsuarioHelper = record helper for TTipoUsuario
    function Descricao: string;
  end;
```

## Alimentando o ComboBox

```pascal
cbxTipo.Items.AddObject(
  'Selecione',
  TObject(NativeInt(tpuNaoIdentificado))
);

for Tipo := tpuBalcao to High(TTipoUsuario) do
begin
  cbxTipo.Items.AddObject(
    Tipo.Descricao,
    TObject(NativeInt(Tipo))
  );
end;
```

---

## Obtendo o Enum selecionado

```pascal
var
  Tipo: TTipoUsuario;

if cbxTipo.TryGetEnum<TTipoUsuario>(Tipo) then
  Usuario.Tipo := Tipo;
```

---

## Selecionando um Enum

```pascal
cbxTipo.TrySetEnum<TTipoUsuario>(Usuario.Tipo);
```

---

# Exemplo das funcionalidades básicas

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  cbxOperacao.LoadFromStrings(
    ['Entrada', 'Saída', 'Transferência'],
    'Selecione...',
    True
  );
end;

procedure TForm1.cbxOperacaoDropDown(Sender: TObject);
begin
  cbxOperacao.AdjustDropDownWidth;
end;

procedure TForm1.cbxOperacaoMouseEnter(Sender: TObject);
begin
  cbxOperacao.ShowTextHint;
end;
```

---

# Estrutura do Repositório

```
TComboBoxHelper/
│
├── src/
│   ├── classes/
│   │   └── uComboBoxHelper.pas
│   │
│   └── DemoComboBox/
│       └── DemoComboBox.dproj
│
└── README.md
```

---

# Projeto de Exemplo

Na pasta

```
src/DemoComboBox/
```

há um projeto demonstrando:

- Ajuste automático da largura;
- Hint automático;
- Carregamento por `array of string`;
- Carregamento por `TStrings`;
- Item padrão selecionável;
- Utilização com Enumeradores;
- `TryGetEnum<T>`;
- `TrySetEnum<T>`.

---

# Como adicionar ao projeto

Inclua o arquivo:

```
src/classes/uComboBoxHelper.pas
```

Depois adicione:

```pascal
uses
  uComboBoxHelper;
```

E utilize normalmente:

```pascal
ComboBox1.LoadFromStrings(Lista);

ComboBox1.AdjustDropDownWidth;

ComboBox1.ShowTextHint;

ComboBox1.TryGetEnum<TMeuEnum>(Valor);

ComboBox1.TrySetEnum<TMeuEnum>(Valor);
```