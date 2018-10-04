RANGE_TABLE = 'B5:P226';

var sheet = SpreadsheetApp.getActiveSpreadsheet();
var tableRange = sheet.getRange(RANGE_TABLE);

/**
 * Generate all component tables.
 */ 
function generateAllComponentTables(){
  generateTable_('M', 'Mechanical Components Table', 'tab:components-table-mechanical', 'E300');
  generateTable_('E', 'Electrical Components Table', 'tab:components-table-electrical', 'E302');
  generateTable_('O', 'Other Components Table', 'tab:component-table-other', 'E304');
}

/**
 * Generate speficic component table based on provided arguments.
 */
function generateTable_(divisionCode, caption, label, outputCell) {

  var header = '\\ begin{longtable} ' +
  '{|m{0.05\\ textwidth}|m{0.25\\ textwidth}|m{0.15\\ textwidth}|m{0.2\\ textwidth}|m{0.05\\ textwidth}|m{0.07\\ textwidth}|m{0.07\\ textwidth}|m{0.25\\ textwidth}|m{0.11\\ textwidth}|} ' +
  '\\ hline ' +
  '\\ textbf{ID} & \\ textbf{Component Name} & \\ textbf{Manufacturer} & \\ textbf{Manufacturer Code} & \\ textbf{Qty} & \\ textbf{Total Mass [g]} & \\ textbf{Total Cost [Eur]}  & \\ textbf{Note}  & \\ textbf{Status} \\\\  \\ hline ';
  
  var footer = '\\ caption{' + caption + '} ' +
    '\\ label{' + label + '} ' +
    '\\ end{longtable} ' +
    '\\ raggedbottom';
      
  var rowArray = new Array();

  var numRows = tableRange.getNumRows();
  var numCols = tableRange.getNumColumns();
  
  for (var i = 1; i <= numRows; i++) {
    var id = tableRange.getCell(i, 13).getValue();
    
    if(id.toString().indexOf(divisionCode) == 0){
  
      var itemNumber = tableRange.getCell(i, 1).getValue();
      var itemSubNumber = '';
      var component = tableRange.getCell(i, 2).getValue();
      
      if(itemNumber == ''){
        itemSubNumber = tableRange.getCell(i, 2).getValue();
        component = tableRange.getCell(i, 3).getValue();
      }
      
      var manufacturerCode = tableRange.getCell(i, 4).getValue();
      var quantity = tableRange.getCell(i, 5).getValue();
      
      var unitMass = tableRange.getCell(i, 6).getValue();
      if (unitMass != 'n/a' && totalMass != '' && totalMass != '-'){
        unitMass = significantFigure_(unitMass, 2);
      }
      
      var unitCost = tableRange.getCell(i, 7).getValue();
      if (unitCost != 'n/a' && unitCost != '' && unitCost != '-'){
        unitCost = significantFigure_(unitCost, 2);
      }
      
      var totalMass = tableRange.getCell(i, 8).getValue();
      if (totalMass != 'n/a' && totalMass != '' && totalMass != '-'){
        totalMass = significantFigure_(totalMass, 2);
      }

      var totalCost = tableRange.getCell(i, 9).getValue();
      if (totalCost != 'n/a' && totalCost != '' && totalCost != '-'){
        totalCost = significantFigure_(totalCost, 2);
      }
      
      var sponsor = tableRange.getCell(i, 10).getValue();
      var manufacturer = tableRange.getCell(i, 12).getValue();
      var status = tableRange.getCell(i, 14).getValue();
      var note = tableRange.getCell(i, 15).getValue();
      
      var key = padStart_(id.substr(1), 2, "0")
      rowArray[key] = '' + id + ' & ' + component + ' & ' + manufacturer + ' & ' + manufacturerCode + ' & '  + quantity + ' & ' + totalMass + ' & ' + totalCost + ' & ' + note + ' & ' + status + ' \\\\  \\ hline ';
      
    }
     
  }
  
  // Make sure that rows are sorted by their Component IDs.
  var rowBuffer = '';
  var sortedComponentIds = keys_(rowArray, true);
  for (var i = 0; i < sortedComponentIds.length; i++) {
    rowBuffer = rowBuffer + rowArray[sortedComponentIds[i]];
  }
  
  // Building LaTeX string for the entire component table.
  var completeTable = header + rowBuffer + footer;
  completeTable = completeTable.replace(/\\ /g, '\\');
  
  // Output to spreadsheet so it can be copy and pasted into SED.
  var cell = sheet.getRange(outputCell);  
  cell.setValue(completeTable);
  
  return completeTable
}

/**
 * Get keys of an array
 */
function keys_(obj, sorted){
    var keys = [];
    for(var key in obj){
        if(obj.hasOwnProperty(key)){
            keys.push(key);
        }
    }
    
    if(sorted){
      return keys.sort();
      
    }else{
      return keys;
    }
}

/**
 * Format numbers 
 */
function significantFigure_(n, sig) {
  var mult = Math.pow(10, sig - Math.floor(Math.log(n) / Math.LN10) - 1);
  return Math.round(n * mult) / mult;
}

/**
 * The padStart() method pads the current string with another string (repeated, if needed)
 * so that the resulting string reaches the given length. The padding is applied from 
 * the start (left) of the current string.
 *
 * Source code taken from here:
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/padStart
 */
function padStart_(str, targetLength, padString) {
  targetLength = targetLength >> 0; // truncate if number or convert non-number to 0;
  padString = String((typeof padString !== 'undefined' ? padString : ' '));
  
  if (str.length > targetLength){
    return String(str);
    
  }else {
  
    targetLength = targetLength - str.length;
    if (targetLength > padString.length) {
      //append to original to ensure we are longer than needed
      padString += padString.repeat(targetLength/padString.length);
    }
    
    return padString.slice(0, targetLength) + String(str);
  }
}