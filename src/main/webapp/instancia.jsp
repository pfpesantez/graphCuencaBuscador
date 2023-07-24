<%-- 
    Author     : graphCuenca
--%>
<%@page import="jdk.jfr.internal.Repository"%>
<%@page import="org.eclipse.rdf4j.repository.config.RepositoryConfig"%>
<%@page import="org.apache.jena.graph.GraphUtil"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
<%-- <%@page import="javax.annotation.Resource"%>--%>
<%@page import="org.eclipse.rdf4j.repository.config.RepositoryConfigSchema"%>
<%@page import="org.eclipse.rdf4j.rio.helpers.StatementCollector"%>
<%@page import="org.eclipse.rdf4j.rio.Rio"%>
<%@page import="org.eclipse.rdf4j.rio.RDFFormat"%>
<%@page import="com.github.jsonldjava.core.RDFParser"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.swing.tree.TreeModel"%>
<%@page import="org.eclipse.rdf4j.repository.manager.RepositoryManager"%>
<%@page import="org.eclipse.rdf4j.repository.manager.LocalRepositoryManager"%>
<%@page import="java.io.File"%>
<%@page import="com.ontotext.graphdb.repository.http.GraphDBHTTPRepositoryBuilder"%>
<%@page import="com.ontotext.graphdb.repository.http.GraphDBHTTPRepository"%>
<%@page import="org.eclipse.rdf4j.query.TupleQueryResult"%>
<%@page import="org.eclipse.rdf4j.repository.RepositoryConnection"%>
<%@page import="org.apache.jena.rdf.model.Model"%>
<%@page import="org.apache.jena.rdf.model.ModelFactory"%>
<%@page import="org.eclipse.rdf4j.query.*"%>
<%@page import="org.eclipse.rdf4j.model.Resource"%>
<%@page import="org.eclipse.rdf4j.model.Value"%>
<%@page import="org.eclipse.rdf4j.query.BindingSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
	<head>
		<title>Recurso Turístico</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">
             <%    
                 
                    // Conéctarse a un repositorio remoto usando la API del cliente de GraphDB

                    GraphDBHTTPRepository repository = new GraphDBHTTPRepositoryBuilder()
                            .withServerUrl("http://localhost:7200")
                            .withRepositoryId("graphCuenca")
                            //.withCluster(); // modo de cluster eliminando el comentario
                            .build();

                    // Conexión separada a un repositorio
                    RepositoryConnection connection = repository.getConnection();

       
                %>    

		
			<section id="header">
				<div class="inner">
					
					<h1><strong>RECURSOS TURISTICOS DE LA CIUDAD DE CUENCA</strong></h1>
					<p>Prototipo semántico para la búsqueda de recursos turísticos de la ciudad de Cuenca, Ecuador</p>
                                        <h1><strong><%=request.getParameter("txtnombre")%></strong></h1>
					<ul class="actions special">
						<li><a href="#one" class="button scrolly">Descubrir más...</a></li>
					</ul>
				</div>
			</section>

		
			<section id="one" class="main style1">
				<div class="container">
					<div class="row gtr-150">
						<div class="col-6 col-6-medium">
							<header class="major">
                                                    <% 
                                                        try {
                                                                // Consulta SELECT para evaluación posterior
                                                               
                                                                String recurso=request.getParameter("txtidrecurso");
                                                                if(recurso.equals("Monumentos"))
                                                               
                                                                {
                                                                    TupleQuery tupleQuery = connection.prepareTupleQuery(QueryLanguage.SPARQL,
                                                                        "PREFIX onto: <http://www.utpl.edu.ec/graphCuenca#>" +
                                                                        "PREFIX schema: <http://schema.org/>" +
                                                                        "PREFIX utpl: <http://www.utpl.edu.ec/>" +
                                                                        "PREFIX dct: <http://purl.org/dc/terms/>" +
                                                                        "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +


                                                                        "SELECT distinct ?urirecurso ?nombre ?direccion ?descripcion  ?latitude " +
                                                                        "?longitude ?acceso ?nombreAuthor ?jobAutor ?anoNacimientoAutor ?ciudadNacimientoAutor " +
                                                                        "where {" +
                                                                               "<" + request.getParameter("txtid") +"> a ?objeto;" +
                                                                                "schema:address ?direccion;" +
                                                                                "schema:name ?nombre;" +
                                                                                "schema:description ?descripcion;" +
                                                                                "schema:latitude ?latitude;" +
                                                                                "schema:longitude ?longitude;" +
                                                                                "schema:author ?uriAutor;" +
                                                                                "dct:subject ?uriAcceso." +
                                                                                "?uriAcceso rdfs:label ?acceso." +
                                                                                "?uriAutor schema:additionalName ?nombreAuthor;" +
                                                                                          "schema:jobTitle ?jobAutor;" +
                                                                                          "onto:birthYear ?anoNacimientoAutor;" +
                                                                                          "schema:birthPlace ?uriLugarNacimientoAutor." +
                                                                                "?uriLugarNacimientoAutor schema:name ?ciudadNacimientoAutor." +
                                                                                "Filter (lang(?acceso)in('es'))." +
                                                                                                                                                                                                                                        
                                                                                "}");


                                                                     // Ejecutando la consultadevuelve un objeto similar a un iterador
                                                                    // que se puede recorrer con los métodos hasNext() y next()
                                                                    TupleQueryResult tupleQueryResult = tupleQuery.evaluate();
                                                                    while (tupleQueryResult.hasNext()) 
                                                                    {
                                                                        // Cada resultado está representado por un BindingSet, que corresponde a una fila de resultados
                                                                        BindingSet bindingSet = tupleQueryResult.next();


                                                                        Value nombre = bindingSet.getValue("nombre");
                                                                        Value direccion = bindingSet.getValue("direccion");
                                                                        Value acceso = bindingSet.getValue("acceso");
                                                                        
                                                                        Value descripcion = bindingSet.getValue("descripcion");
                                                                        Value nombreAuthor = bindingSet.getValue("nombreAuthor");
                                                                        Value jobAutor = bindingSet.getValue("jobAutor");
                                                                        Value anoNacimientoAutor = bindingSet.getValue("anoNacimientoAutor");
                                                                        Value ciudadNacimientoAutor = bindingSet.getValue("ciudadNacimientoAutor"); 
                                                             
                                                           
                                                                        %>   
                                                                          
                                                                           <p><strong>Monumento: <%=nombre%></strong><p/>
                                                                           <p><strong>Dirección: </strong><%=direccion%><p/>
                                                                           <p><strong>Horario: </strong>Al aire libre<p/>
                                                                           <p><strong>Acceso: </strong><%=acceso%><p/>
                                                                           <p><strong>Breve descripción.</strong><p/>                              
                                                                           <p><%=descripcion%><p/><br> 
                                                                           <p><strong>Autor Monumento</strong><p/>
                                                                           <p><strong>Nombre: </strong><%=nombreAuthor%><p/>
                                                                           <p><strong>Ocupación: </strong><%=jobAutor%><p/>
                                                                           <p><strong>Año nacimiento: </strong><%=anoNacimientoAutor%><p/>
                                                                           <p><strong>Lugar nacimiento: </strong><%=ciudadNacimientoAutor%><p/>

                                                                        <%    

                                                                        // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                        //Binding binding = bindingSet.getBinding("x");
                                                                    }

                                                                    // Una vez que hayamos terminado con un resultado en particular, debemos cerrarlo.
                                                                    tupleQueryResult.close();
                                                                }
                                                                  
                                                                if(recurso.equals("Iglesias"))
                                                               
                                                                {
                                                                    TupleQuery tupleQuery = connection.prepareTupleQuery(QueryLanguage.SPARQL,
                                                                        "PREFIX onto: <http://www.utpl.edu.ec/graphCuenca#>" +
                                                                        "PREFIX schema: <http://schema.org/>" +
                                                                        "PREFIX utpl: <http://www.utpl.edu.ec/>" +
                                                                        "PREFIX dct: <http://purl.org/dc/terms/>" +
                                                                        "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>" +


                                                                        "SELECT distinct ?urirecurso ?nombre ?direccion ?descripcion  ?latitude " +
                                                                        "?longitude ?openingHours " +
                                                                        "where {" +
                                                                               "<" + request.getParameter("txtid") +"> a ?objeto;" +
                                                                                "schema:address ?direccion;" +
                                                                                "schema:name ?nombre;" +
                                                                                "schema:description ?descripcion;" +
                                                                                "schema:latitude ?latitude;" +
                                                                                "schema:longitude ?longitude;" +
                                                                                "schema:openingHours ?openingHours;" +
                                                                                
                                                                                                                                                                                                                                        
                                                                                "}");


                                                                     // Ejecutando la consultadevuelve un objeto similar a un iterador
                                                                    // que se puede recorrer con los métodos hasNext() y next()
                                                                    TupleQueryResult tupleQueryResult = tupleQuery.evaluate();
                                                                    while (tupleQueryResult.hasNext()) 
                                                                    {
                                                                        // Cada resultado está representado por un BindingSet, que corresponde a una fila de resultados
                                                                        BindingSet bindingSet = tupleQueryResult.next();


                                                                        Value nombre = bindingSet.getValue("nombre");
                                                                        Value direccion = bindingSet.getValue("direccion");
                                                                        Value openingHours = bindingSet.getValue("openingHours");
                                                                        
                                                                        Value descripcion = bindingSet.getValue("descripcion");
                                                                       
                                                             
                                                           
                                                                        %>   
                                                                          
                                                                           <p><strong>Iglesia: <%=nombre%></strong><p/>
                                                                           <p><strong>Dirección: </strong><%=direccion%><p/>
                                                                           <p><strong>Horario: </strong><%=openingHours%><p/>
                                                                           <p><strong>Breve descripción.</strong><p/>  
                                                                            <p><%=descripcion%><p/><br> 
                                                                          

                                                                        <%    

                                                                        // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                        //Binding binding = bindingSet.getBinding("x");
                                                                    }

                                                                    // Una vez que hayamos terminado con un resultado en particular, debemos cerrarlo.
                                                                    tupleQueryResult.close();
                                                                }
                                                            //Se pueden realiza más consultas con el mismo objeto de conexión
                                                           } finally {
                                                            // Lo mejor es cerrar la conexión en un bloque finally.
                                                             //connection.close();
                                                             }
                                                    %>
								
								
						</header>
                                                 
							
						</div>
						<div class="col-3-xlarge">
							<table class="default">

                                                                <tr>
                                                                  <th>Recursos Imágenes</th>
                                                                </tr>

                                                               
                                                                    <%    
                                                                            try {
                                                                                     // Consulta SELECT para evaluación posterior



                                                                                         TupleQuery tupleQueryC1 = connection.prepareTupleQuery(QueryLanguage.SPARQL,
                                                                                             "PREFIX onto: <http://www.utpl.edu.ec/graphCuenca#>" +
                                                                                             "PREFIX schema: <http://schema.org/>" +
                                                                                             "select ?urlImagen ?tituloImagen " +                                                                                             
                                                                                             "where {" +
                                                                                                     "?uriImagen a schema:ImageObject;" +
                                                                                                     "schema:contentLocation <" + request.getParameter("txtid") +">;" +
                                                                                                     "schema:url ?urlImagen;" +
                                                                                                     "schema:name ?tituloImagen." +  
                                                                                                     
                                                                                                     "}");


                                                                                          // Ejecutando la consultadevuelve un objeto similar a un iterador
                                                                                         // que se puede recorrer con los métodos hasNext() y next()
                                                                                         TupleQueryResult tupleQueryResultC1 = tupleQueryC1.evaluate();
                                                                                         while (tupleQueryResultC1.hasNext()) 
                                                                                         {
                                                                                             // Cada resultado está representado por un BindingSet, que corresponde a una fila de resultados
                                                                                             BindingSet bindingSet = tupleQueryResultC1.next();


                                                                                             Value urlImagen = bindingSet.getValue("urlImagen");
                                                                                             Value tituloImagen = bindingSet.getValue("tituloImagen");
                                                                                             
                                                                    %>   
                                                                                              <tr>
                                                                                               <td><a href=<%=urlImagen%>><%=tituloImagen%><a/><td/> 
                                                                                              </tr>
                                                                                             <%    
                                                                                            
                                                                                             // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                                             //Binding binding = bindingSet.getBinding("x");


                                                                                         // Una vez que hayamos terminado con un resultado en particular, debemos cerrarlo.
                                                                                        
                                                                                     }

                                                                                  tupleQueryResultC1.close();
                                                                                 //Se pueden realiza más consultas con el mismo objeto de conexión
                                                                                } finally {
                                                                                 // Lo mejor es cerrar la conexión en un bloque finally.
                                                                                  
                                                                                  }
                                                                         %>

                                                              </table>
						</div>
                                                <div class="col-3-xlarge">
							<table class="default">

                                                                <tr>
                                                                  <th>Recursos Videos</th>
                                                                 </tr>

                                                               
                                                                    <%    
                                                                            try {
                                                                                     // Consulta SELECT para evaluación posterior

                                                                                         TupleQuery tupleQueryC1 = connection.prepareTupleQuery(QueryLanguage.SPARQL,
                                                                                             "PREFIX onto: <http://www.utpl.edu.ec/graphCuenca#>" +
                                                                                             "PREFIX schema: <http://schema.org/>" +
                                                                                             "select ?urlVideo ?tituloVideo " +                                                                                             
                                                                                             "where {" +
                                                                                                     "?uriVideo a schema:VideoObject;" +
                                                                                                     "schema:url <" + request.getParameter("txtid") +">;" +
                                                                                                     "schema:identifier ?urlVideo;" +
                                                                                                     "schema:name ?tituloVideo." +  
                                                                                                     "}");


                                                                                          // Ejecutando la consultadevuelve un objeto similar a un iterador
                                                                                         // que se puede recorrer con los métodos hasNext() y next()
                                                                                         TupleQueryResult tupleQueryResultC1 = tupleQueryC1.evaluate();
                                                                                         while (tupleQueryResultC1.hasNext()) 
                                                                                         {
                                                                                             // Cada resultado está representado por un BindingSet, que corresponde a una fila de resultados
                                                                                             BindingSet bindingSet = tupleQueryResultC1.next();


                                                                                             Value urlVideo = bindingSet.getValue("urlVideo");
                                                                                             Value tituloVideo = bindingSet.getValue("tituloVideo");
                                                                                             String urlVideoCadena= "https://www.youtube.com/watch?v=" + urlVideo.stringValue();
                                                                                 

                                                                                             %>   
                                                                                              <tr>
                                                                                               <td><a href=<%=urlVideoCadena%>><%=tituloVideo%><a/><td/> 
                                                                                              </tr>
                                                                                             <%    

                                                                                             // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                                             //Binding binding = bindingSet.getBinding("x");
                                                                                         // Una vez que hayamos terminado con un resultado en particular, debemos cerrarlo.
                                                                                        
                                                                                     }

                                                                                  tupleQueryResultC1.close();
                                                                                 //Se pueden realiza más consultas con el mismo objeto de conexión
                                                                                } finally {
                                                                                 // Lo mejor es cerrar la conexión en un bloque finally.
                                                                                  connection.close();
                                                                                  }
                                                                         %>

                                                              </table>
						</div>                                                                         
					</div>
				</div>
			</section>

	
			<section id="footer">
				<ul class="icons">
					
					<li><a href="#" class="icon solid alt fa-envelope"><span class="label">Email</span></a></li>
				</ul>
				<ul class="copyright">
					<li>&copy; graphCuenca</li>
				</ul>
			</section>

		
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>