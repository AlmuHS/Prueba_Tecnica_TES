<?php
function OpenCon()
{
        $dbhost = "10.132.0.5";
        $dbuser = "user1";
        $dbpass = "test1";
        $db = "test_db";
        $conn = new mysqli($dbhost, $dbuser, $dbpass,$db);
        return $conn;
}
function CloseCon($conn)
{
        $conn -> close();
}
$conn = OpenCon();
echo "Connected Successfully <br>";

$tipo_usr = "";
$nombre_ = "";

if (isset($_POST['consultar'])) {

        if(isset($_POST['nombre_usuario'])){
                $nombre_ = $_POST["nombre_usuario"];
        }
         $tipo_usr = $_POST["tipo_usuario"];
         
         if($tipo_usr != "" && $nombre_ != ""){
                $tipo_upper = strtoupper($tipo_usr);
                  
                $query = "SELECT * FROM USUARIOS INNER JOIN $tipo_upper ON(USUARIOS.ID = $tipo_upper.ID) WHERE USUARIOS.USUARIO like '$nombre_'";
                $resultado = mysqli_query($conn,$query);

                print("Los datos del usuario {$nombre_} son: ");
                while($row = mysqli_fetch_assoc($resultado)) {
                        print_r($row);
                }
         }
         else if($nombre_ == "" && $tipo_usr != ""){
                $tipo_upper = strtoupper($tipo_usr);
                  
                $query = "SELECT * FROM USUARIOS INNER JOIN $tipo_upper ON(USUARIOS.ID = $tipo_upper.ID)";
                
                $resultado = mysqli_query($conn,$query);

                print("Los $tipo_usr registrados en la base de datos son: ");
                while($row = mysqli_fetch_assoc($resultado)) {
                        print("{$row['usuario']}, ");
                }
         }
}
   
//CloseCon($conn);
?>

<html>
<body>
  <div>
  <form method="post" action="<?php echo $_SERVER['PHP_SELF'];?>"> 
        <div id="page" class="container">
        Tipo de Usuario:
	<input type="radio" name="tipo_usuario"
	value="alumnos">Alumnos
	<input type="radio" name="tipo_usuario"
	value="profesores">Profesores
	</div>
        <input type="text" id="nombre" name="nombre_usuario" maxlength="50" size="20">

        <input type="submit" name="consultar" value="consultar" />
  </div>
  </form>
</body>
</html>

