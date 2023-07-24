<%-- 
    Author     : graphCuenca
--%>
<%@page import="jdk.jfr.internal.Repository"%>
<%@page import="org.eclipse.rdf4j.repository.config.RepositoryConfig"%>
<%@page import="org.apache.jena.graph.GraphUtil"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
<%@page import="org.eclipse.rdf4j.model.IRI"%>
<%@page import="javax.annotation.Resource"%>
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
<%@page import="org.eclipse.rdf4j.model.Value"%>
<%@page import="org.eclipse.rdf4j.query.BindingSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>Prototipo Semántico - Recursos</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
                <script
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_xuXNsimj8lqMb_qa90o_RqepAMx4AeY&callback=initMap&libraries=&v=weekly">
            
                </script>
                <style type="text/css">
                    
                        /* Establecer la altura del mapa para definir el tamaño del div
                         * que contiene el mapa */
                        #map {
                          height: 100%;
                        }

                        /* Opcional: hace que la página de muestra llene la ventana. */
                        html,
                        body {
                          height: 100%;
                          margin: 0;
                          padding: 0;
                        }
              </style>
            <script>

            function initMap() {
                const map = new google.maps.Map(document.getElementById("map"), {
                  zoom: 15,
                  center: { lat: -2.90055, lng: -79.00453 },   
                });
                // Crea una matriz de caracteres alfabéticos utilizados para etiquetar los marcadores..
                const labels = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                // Agregar algunos marcadores al mapa.
                // El código utiliza el método JavaScript Array.prototype.map() para
                // crear una matriz de marcadores basada en una matriz de "ubicaciones" dada.
                // El método map() no tiene nada que ver con la API de Google Maps.
                const markers = locations.map((location, i) => {
                    return new google.maps.Marker({
                    position: location,
                    label: labels[i % labels.length]
                  });
                });
                // Agregue un agrupador de marcadores para administrar los marcadores.
                new MarkerClusterer(map, markers, {
                  imagePath:
                    "https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m"
                });
              }
              const locations = [
                { lat: -2.8940722, lng: -79.0055215 },//luis coredro y Sangurima
                { lat: -2.888847, lng: -79.0045973 },//luis coredro  y heroes de verdeloma
                { lat: -2.9014631, lng: -79.0069176 },//luis coredro y larga
                { lat: -2.902809, lng: -79.0221543 },//av Loja y Pichincha
                { lat: -2.9135563, lng: -79.0069176 },//av loja y don bosco
                { lat: -2.9106384, lng: -79.0011198 },//paucarbamba y Luis Moreno Mora
                { lat: -2.90608, lng: -78.9858285 }//Max hule y pumapungo

              ];
                google.maps.event.addDomListener(window, 'load', initMap);
            </script>
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
                                        <h1><strong><%=request.getParameter("txtrecurso")%></strong></h1>
					<ul class="actions special">
						<li><a href="#one" class="button scrolly">Descubrir más...</a></li>
					</ul>
				</div>
			</section>

		
			<section id="one" class="main style1">
				<div class="container">
					<div class="row gtr-150">
					    <div class="col-6 col-12-medium">
						<header class="major">
                                                      <% 
                                                        try {
                                                                // Consulta SELECT para recursos seleccionados
                                                                TupleQuery tupleQuery = connection.prepareTupleQuery(QueryLanguage.SPARQL,
                                                                        "PREFIX onto: <http://www.utpl.edu.ec/graphCuenca#>" +
                                                                        "PREFIX schema: <http://schema.org/>" +
                                                                        "PREFIX utpl: <http://www.utpl.edu.ec/>" +
                                                                        "SELECT distinct ?s ?n ?o ?l ?lg where {" +
                                                                            "?s a "+ request.getParameter("txturi") +";" +
                                                                               "schema:address ?o;" +
                                                                               "schema:name ?n;" +
                                                                               "schema:latitude ?l;" +
                                                                               "schema:longitude ?lg." +
                                                                               "}");

                                                                // Ejecutando la consultadevuelve un objeto similar a un iterador
                                                                // que se puede recorrer con los métodos hasNext() y next()
                                                                TupleQueryResult tupleQueryResult = tupleQuery.evaluate();
                                                                while (tupleQueryResult.hasNext()) 
                                                                {
                                                                    // Cada resultado está representado por un BindingSet, que corresponde a una fila de resultados
                                                                    BindingSet bindingSet = tupleQueryResult.next();
                                                                  // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                   //Binding binding = bindingSet.getBinding("x");
                                                                     Value nombre = bindingSet.getValue("n");
                                                                     Value direccion = bindingSet.getValue("o");
                                                                     Value uriRecurso = bindingSet.getValue("s");
                                                                     Value latitud = bindingSet.getValue("l");
                                                                     Value longitud = bindingSet.getValue("lg");

                                                                   

                                                                    %>   
                                                                      <p><strong><%=nombre%></strong><p/>
                                                                      <p><%=direccion%><p/>

                                                                      <form action="Controlador">
                                                                       <div class="form-group">
                                                                        <input type="hidden" name="txtnombre" value=<%=nombre%>>   
                                                                        <input type="hidden" name="txtid" value=<%=uriRecurso%>>
                                                                        <input type="hidden" name="txtidrecurso" value=<%=request.getParameter("txtrecurso")%>>
                                                                                                                              </div> 
                                                                           <input class="btn btn-success btn-block" type="submit" name="accion" value="Ir">
                                                                      </form>
                                                              <%  
                                          
                                                                              // También se puede acceder a los Bindings explícitamente por nombre de variable
                                                                              //Binding binding = bindingSet.getBinding("x");
                                                                }

                                                                  // Una vez que hayamos terminado con un resultado en particular, debemos cerrarlo.
                                                                  tupleQueryResult.close();

                                                                          //Se pueden realiza más consultas con el mismo objeto de conexión
                                                            } finally {
                                                            // Lo mejor es cerrar la conexión en un bloque finally.
                                                            connection.close();
                                                      }
                                                    %>
								
                                                  	
					    </header>
                                             	
						</div>
						<div class="col-6 col-12-medium imp-medium">
                                                       <div class="form-group text-center">
                                                       <div id="map" style="height:600px; width:650px"></div>
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

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/jquery.scrolly.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>