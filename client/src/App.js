import {BrowserRouter, Routes, Route} from 'react-router-dom'
import ListaUsuarios from './components/ListaUsuarios'
import CrearUsuario from './components/CrearUsuario'
import {Container} from '@mui/material' // es como el css
import Menu from './components/Navegar'

function App() {
  return (
    <BrowserRouter>
    <Menu /> {/** esto lo que hace es crear el menu para todos los componenetes  */}
    <Container>
      <Routes>
      <Route>
        <Route path='/' element={<ListaUsuarios />}/>
        <Route path='/usuarios/nuevo' element={<CrearUsuario />}/>
        <Route path='/usuarios/:id/edit' element={<CrearUsuario />}/>
      </Route>
    </Routes>
    </Container>
    
    </BrowserRouter>
  )
}

export default App