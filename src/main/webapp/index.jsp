<%-- 
    Author     : graphCuenca
--%>
<%@page import="jdk.jfr.internal.Repository"%>
<%@page import="org.eclipse.rdf4j.repository.config.RepositoryConfig"%>
<%@page import="org.apache.jena.graph.GraphUtil"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
<%@page import="org.eclipse.rdf4j.model.vocabulary.RDF"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<html>
	<head>
		<title>Prototipo Semántico</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
	</head>
	<body class="is-preload">
            

		<!-- Header -->
			<section id="header">
				<div class="inner">
					
					<h1><strong>PROTOTIPO SEMANTICO</strong></h1>
					<p>Prototipo semántico para la búsqueda de recursos turísticos de la ciudad de Cuenca, Ecuador</p>
                                       
					<ul class="actions special">
						<li><a href="#footer" class="button scrolly">Descubrir más...</a></li>
					</ul>
				</div>
			</section>

		
		
		
			<section id="three" class="main style1 special">
				<div class="container">
					<header class="major">
						<h2>Recursos Turísticos de la ciudad de Cuenca</h2>
					</header>
					<p>Tenemos para este prototipo los siguientes recursos:</p>
					<div class="row gtr-150">
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/Museo.jpeg" alt="" width="400"  height="341" /></span>
							
							<ul class="actions special">
							 <form action="Controlador">
                                                            <div class="form-group">
                                                               <input type="hidden" name="txturi" value="schema:Museum">
                                                               <input type="hidden" name="txtrecurso" value="Museos">
                                                             </div> 
                                                            <input class="btn btn-success btn-block" type="submit" name="accion" value="Museos">
                                                          </form>
							</ul>
                                                        
                                                         
						</div>
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/Iglesia.jpeg" alt="" width="400"  height="341"/></span>
							
							<ul class="actions special">
							 <form action="Controlador">
                                                            <div class="form-group">
                                                               <input type="hidden" name="txturi" value="schema:CatholicChurch">
                                                               <input type="hidden" name="txtrecurso" value="Iglesias">
                                                             </div> 
                                                            <input class="btn btn-success btn-block" type="submit" name="accion" value="Iglesias">
                                                          </form>
							</ul>
						</div>
						<div class="col-4 col-12-medium">
							<span class="image fit"><img src="images/Monumento.jpeg" alt="" width="400"  height="341" /></span>
							
							<ul class="actions special">
							 <form action="Controlador">
                                                            <div class="form-group">
                                                               <input type="hidden" name="txturi" value="utpl:Monument">
                                                               <input type="hidden" name="txtrecurso" value="Monumentos">
                                                             </div> 
                                                            <input class="btn btn-success btn-block" type="submit" name="accion" value="Monumentos">
                                                          </form>
							</ul>
							</ul>
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