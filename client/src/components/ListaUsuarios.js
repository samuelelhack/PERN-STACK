import { Button, Card, CardContent, Grid2, TextField, Typography, MenuItem, Select, FormControl, InputLabel, listClasses } from "@mui/material"
import { useEffect } from "react" //sirve para hacer peticiones al backend
import { useState } from "react"
import { useNavigate } from "react-router-dom";

function ListaUsuarios() {


  const navigate = useNavigate()
  
  // LISTAR USUARIOS
  const [Lista, setLista] = useState([])

  const cargarTareas = async () => {
    const res = await fetch('http://localhost:4000/tareas')
    const data = await res.json();
    setLista(data)
    console.log(data)
  }


  // BOTON DELETE
  const handleDelete = async (id) => {
    console.log(id)
    try {
      const res = await fetch(`http://localhost:4000/tareas/${id}`, {
        method: 'DELETE',
      });
    
      setLista(Lista.filter(Lista => Lista.id !== id)); //esto lo que hace es filtrar el array es decir va a mantener todos los datos que sean distintos al id que vamos a eliminar
      // esto se hace asi para no tener que recargar la pagina
      console.log(res) //como el delete en el backend no devuelve un json solo vemos la respuesta

    } catch (error) {
      console.log(error)
    }
    
  }

  //RECIBIR DATOS
  useEffect(() => {
    cargarTareas()
   
  }, [])

  return (
    <>
    <h1>LISTA DE USUARIOS</h1>
      {
        Lista.map((lista) => (
          <Card style={{
            marginBottom: '.7rem',
            backgroundColor: '#1e272e',
           
          }}
          key = {lista.id}
          >
            <CardContent style={{display: 'flex', justifyContent: 'space-between'}}>
              <div style={{color: 'white'}}>
              <Typography>{lista.nombre}</Typography>
              <Typography>{lista.correo}</Typography>
              <Typography>{lista.rol}</Typography>
              <Typography>{lista.clave}</Typography>
              </div>
              
              <div>
              <Button 
              variant="contained" 
              color="inherit" 
              onClick={() => navigate(`/usuarios/${lista.id}/edit`)}>
                editar
              </Button>

              <Button  
              variant="contained" 
              color="warning" 
              onClick={() => handleDelete(lista.id)}

              style={{marginLeft: ".5rem"}}>
                eliminar
              </Button>
              </div>
              
            </CardContent>
          </Card>
        ))
      }
    </>
  )
}

export default ListaUsuarios