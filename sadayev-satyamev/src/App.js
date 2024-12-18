import "./App.css"
import Header from './components/common/heading/Header'
import {BrowserRouter as Router,Switch,Route,Link } from 'react-router-dom'
import About from "./components/about/About"
import CourseHome from "./components/allcourses/CourseHome"
import Pricing from "./components/pricing/Pricing"
import Contact from "./components/contact/Contact"
import Footer from "./components/common/footer/Footer"
import Home from "./components/home/Home"

function App (){
  return (
    <>
      
      <Router>
      <Header />
        <Switch>
          <Route exact path='/' component={Home} />
          <Route exact path='/about' component={About} />
          <Route exact path='/courses' component={CourseHome} />
          <Route exact path='/pricing' component={Pricing} />
          <Route exact path='/contact' component={Contact} />
        </Switch>
        <Footer/>gi
      </Router>
    </>
  );
}

export default App;
