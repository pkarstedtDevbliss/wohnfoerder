import 'dart:html';

InputElement inputSavery;
InputElement inputSave;
InputElement inputCreditEnd;
InputElement inputSaveCredit;
InputElement inputSaveryStart;
InputElement inputCreditStart;

TableElement resultTable;
LabelElement labelFinishedSavery;

void main() {
  querySelector("#calcButton").onClick.listen(calculate);
  resultTable = querySelector("#wohnfoerder_konto");
}

void calculate(MouseEvent event) {
  resultTable.children.clear();
  inputSavery = querySelector("#savery");
  inputSave = querySelector("#save");
  inputCreditEnd = querySelector("#creditend");
  inputSaveCredit = querySelector("#savecredit");
  inputSaveryStart = querySelector("#saverystart");
  inputCreditStart = querySelector("#creditstart");
  labelFinishedSavery = querySelector("#result");
  
  var tributeCredit = 0.02;
  var tributeSavery = 0.01;
  var savery = inputSavery.valueAsNumber;
  var save = inputSave.valueAsNumber;
  var saveCredit= inputSaveCredit.valueAsNumber;
  var erg = 0;
  var sumSavery = savery + save;
  var svt = inputCreditStart.valueAsNumber - inputSaveryStart.valueAsNumber;
  var supportedSave = sumSavery;
  var lifeTime = inputCreditEnd.valueAsNumber - inputCreditStart.valueAsNumber;
  
  for (int i=1; i < svt +1;i++) {
    supportedSave = supportedSave + (supportedSave * tributeSavery);
  }
  labelFinishedSavery.text = "Verzinstes Riesterguthaben bei Zuteilung: " + supportedSave;
  
  for (int i=1; i < lifeTime + 1; i++) {
    var tributeAmount = 0.00;
    erg = erg + supportedSave;
    tributeAmount = erg * tributeCredit;
    erg = erg + tributeAmount;
    
    var row = new TableRowElement();
    var tc1 = new TableCellElement();
    var tc2 = new TableCellElement();
    tc1.text = i.toString() + ". Jahr";
    tc2.text = erg.roundToDouble().toString() + "€";
    row.children.add(tc1);
    row.children.add(tc2);
    resultTable.children.add(row);
  }
  var result = querySelector("#tributeresults");
  var totalPaySum = querySelector("#totalPayAmount");
  var totalPayTax = querySelector("#totalPayTax");
  var monthlySaleryRate = querySelector("#monthlySaleryRate");
  var monthlyPayTax = querySelector("#monthlyPayTax");
  var totalPayAdvantage = 0.7;
  var totalPayTribute = 0.35;
  var seperatlyPayTribute = 0.25;
  var totalPayAmount = erg * totalPayAdvantage;
  var totalTaxAmount = totalPayAmount * totalPayTribute;
  var lt = 17 * 12;
  var monthlyRate = erg / lt;
  var monthlyTaxRate = monthlyRate * seperatlyPayTribute;

  result.setAttribute("style", "display:block");
  totalPaySum.text = "Einmalig zu besteuernder Betrag: " + totalPayAmount.roundToDouble().toString() + " €";
  totalPayTax.text = "Einmalige Steuerlast zum Steuersatz von 35% zum 68. Lebensjahr: " + totalTaxAmount.roundToDouble().toString() + " €";
  monthlySaleryRate.text = "Monatliche fiktive Rente bis zum 85. Lebensjahr: " + monthlyRate.roundToDouble().toString() + " €";
  monthlyPayTax.text = "Monatliche Steuerlast beim Steuerstatz von 25% bis zum 85. Lebensjahr: " + monthlyTaxRate.roundToDouble().toString() + " €"; 
}
