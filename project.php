<html>
 <head>
   <title>project</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>  
           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
           <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>  
           <script src="https://cdn.datatables.net/1.10.12/js/dataTables.bootstrap.min.js"></script>            
           <link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" />  
  </head>
 <body>

 
 
 <?php
// PHP code just started

ini_set('error_reporting', E_ALL);
ini_set('display_errors', true);
// display errors

$db = mysqli_connect("dbase.cs.jhu.edu", "20fa_egan1", "Xrck22yf3Z");
// ********* Remember to use your MySQL username and password here ********* //

if (!$db) {

  echo "Connection failed!";

} else {
//echo "<pre>";
//print_r($_POST);
//echo "</pre>";

  $dMin = isset($_POST['dMin']) ? $_POST['dMin'] : "null";
  $dMax = isset($_POST['dMax']) ? $_POST['dMax'] : "null";
  $gMin = isset($_POST['gMin']) ? $_POST['gMin'] : "null";
  $gMax = isset($_POST['gMax']) ? $_POST['gMax'] : "null";
  $bench = isset($_POST['bench']) ? 1 : "null";
  $rMin = isset($_POST['rMin']) ? $_POST['rMin'] : "null";
  $rMax = isset($_POST['rMax']) ? $_POST['rMax'] : "null";
  $name = isset($_POST['name']) ? $_POST['name'] : "null";
  $angle = isset($_POST['angle']) ? $_POST['angle'] : "null";
  $method = isset($_POST['method']) ? $_POST['method'] : "null";
  $fname = isset($_POST['fname']) ? $_POST['fname'] : "null";
  $lname = isset($_POST['lname']) ? $_POST['lname'] : "null";
  $city = isset($_POST['city']) ? $_POST['city'] : "null";
  $country = isset($_POST['country']) ? $_POST['country'] : "null";

if ($angle == '40' && $method == 'feet') {
$cId = 0;}
else if ($angle == '40' && $method == 'feet screw') {
$cId = 1;}
else if ($angle == '40' && $method == 'kick') {
$cId = 2;}
else if ($angle == '25' && $method == 'feet') {
$cId = 3;}
else if ($angle == '25' && $method == 'feet screw') {
$cId = 4;}
else if ($angle == '40' && $method == 'screw') {
$cId = 5;}
else if ($angle == '25' && $method == 'screw') {
$cId = 6;}
else if ($angle == '25' && $method == 'kick') {
$cId = 7;}
else {
$cId = "null";}

  mysqli_select_db($db,"20fa_egan1_db");
  // ********* Remember to use the name of your database here ********* //

$result1 = mysqli_query($db,"
CALL FilterProblems('$gMin', '$gMax','$dMin', '$dMax', $bench,$rMin, $rMax,'$name', $cId,'$fname', '$lname', '$city', '$country')");
//CALL FilterProblems(null,null,'2018-01-01','2018-11-14',1,0,5,'',0,'','','','')");


  if (!$result1) {

    echo "Query 1 failed!\n"; 
    echo "CALL FilterProblems('$gMin', '$gMax','$dMin', '$dMax', $bench,$rMin, $rMax,'$name', $cId,'$fname', '$lname', '$city', '$country')";
    print mysqli_error($db);

  }
else {
echo "<div class='table-responsive'><table id='results' class='table table-striped table-bordered' border=1>\n";
    echo "<thead><tr>
        <td> pId </td>
     <td>Date</td>
     <td>Grade</td>
     <td>IsBenchmark</td>
     <td>MoonBoardConfiguration</td>
     <td>Name</td>
     <td>Setter</td>
     <td>Repeats</td>
    </tr></thead>\n";
    while ($myrow = mysqli_fetch_array($result1)) {
    printf("<tr><td>%s</td>
      <td>%s</td>
      <td>%s</td>
     <td>%s</td>
     <td>%s</td>
     <td>%s</td>
     <td>%s</td>
      <td>%s</td>
  </tr>\n", $myrow['pId'], $myrow['DateTimeString'],$myrow['Grade'],$myrow['IsBenchmark'],$myrow['MoonBoardConfiguration'],$myrow['Name'],$myrow['Setter'],$myrow['Repeats']
    );
    }

  echo "</table></div>\n";
//print_r($a)
}
}

// PHP code about to end

 ?>

<img src='mbsetup-mbm2017-min.jpg' alt='Moonboard'></img>
 </body>
</html>


<script>$(document).ready(function() {

    var eventFired = function (type) {
        var info = table.page.info();
        var data = table.cell(info.page,0).data();
        console.log(data);
            <?php
        //echo "<script>document.writeln(data);</script>";
$result2 = mysqli_query($db,"CALL GetMoves()");
            ?>
    }
    
    var table = $('#results')
        .on('page.dt', function () { eventFired( 'Page' ); } )
        .DataTable({
        "lengthMenu": [1]
        });
    table.rows({ page: 'current' }).every(function (rowIdx,tableLoop, rowLoop) {
        var data = this.data();
        console.log(data[0]);
    });

} );
</script>
