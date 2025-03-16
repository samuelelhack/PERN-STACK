import { Button, Card, CardContent, Grid2, TextField, Typography, MenuItem, Select, FormControl, InputLabel } from "@mui/material"
import { useEffect } from "react" //sirve para hacer peticiones al backend
import { useState } from "react"

function ListaUsuarios() {

  const [Lista, setLista] = useState([])

  const cargarTareas = async () => {
    const res = await fetch('http://localhost:4000/tareas')
    const data = await res.json();
    setLista(data)
  }
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
           
          }}>
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
              onClick={() => console.log('editando')}>
                editar
              </Button>

              <Button  
              variant="contained" 
              color="warning" 
              onClick={() => console.log('eliminando')}
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