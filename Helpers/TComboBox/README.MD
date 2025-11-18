# TComboBoxHelper

`TComboBoxHelper` é uma extensão simples, leve e reutilizável para o componente `TComboBox` do Delphi.  
Ele centraliza funcionalidades comuns e recorrentes, facilitando o uso do componente em várias telas e reduzindo duplicação de código.

## Funcionalidades Disponíveis

### 1. Ajuste Automático da Largura do DropDown  
**Método:** `AdjustDropDownWidth`  
Garante que nenhum item da lista fique cortado, expandindo o dropdown conforme o maior texto.  
**Recomendado:** chamar no evento **OnDropDown**.

### 2. Exibição Automática de Hint  
**Método:** `ShowTextHint`  
Exibe automaticamente um hint com o texto atual do combo, útil quando o campo é estreito.  
**Recomendado:** chamar no evento **OnMouseEnter**.

### 3. Preenchimento de Itens  
**Método:** `LoadFromStrings`  
Permite preencher o combo de forma simples:

- Usando `array of string`;  
- Usando qualquer `TStrings`;  
- Adicionando um item padrão opcional;  
- Selecionando automaticamente o item padrão, se desejado.

## Exemplo de Uso

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  cbxOperacao.LoadFromStrings(
    ['Entrada', 'Saída', 'Transferência'],
    'Selecione...',
    True // marca o item padrão como selecionado
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

## Estrutura do Repositório

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

## Projeto de Exemplo (Demo)

Dentro da pasta:

```
src/DemoComboBox/
```

Existe um projeto completo demonstrando:

- Ajuste de largura do dropdown;
- Exibição automática de hints;
- Carregamento usando array of string;
- Carregamento usando TStrings;
- Uso de item padrão selecionável;
- Aplicação prática em um formulário real.

Basta abrir o projeto no Delphi, compilar e executar.

## Como adicionar ao seu projeto

1. Inclua no seu projeto o arquivo:

```
src/classes/uComboBoxHelper.pas
```

2. Importe no formulário onde deseja usar:

```pascal
uses
  uComboBoxHelper;
```

3. Use os métodos diretamente:

```pascal
ComboBox1.LoadFromStrings(Lista);
ComboBox1.AdjustDropDownWidth;
ComboBox1.ShowTextHint;
```