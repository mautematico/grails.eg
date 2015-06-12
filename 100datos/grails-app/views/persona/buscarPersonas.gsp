<%@ page import="com.mx.eglobal.Persona" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Buscar personas</title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>            
    <asset:javascript src="grails-angularjs.js"/>
    <asset:stylesheet src="grails-angularjs.css"/>
    <r:require module="export"/>

</head>
<body ng-app="">


    <!-- Modal -->
    <div class="modal fade" id="primary" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">

            <div class="modal-content">
                <div class="modal-header modal-header-primary">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h1><i class="glyphicon glyphicons-database-search"></i> buscar en la base de datos</h1>
                </div>
                <div class="modal-body">
                    
                    
                    <!--formulario-->
                    <g:form action="buscarPersonas" method="GET" class="form-horizontal">
                    <fieldset>
                    <!-- Prepended text-->
                    <div class="form-group">
                      <div class="col-lg-6 col-lg-offset-3 text-center">
                        <div class="input-group">
                          <span class="input-group-addon">nombre</span>
                          <g:textField name="nombre" value="${params.nombre}" id="nombre" name="nombre" class="form-control" placeholder="Filtrar por nombre" type="text"/>
                        </div>
                        <p class="help-block"></p>
                      </div>
                    </div>

                    <!-- Prepended text-->
                    <div class="form-group">
                      <div class="col-lg-6 col-lg-offset-3 text-center">
                        <div class="input-group">
                          <span class="input-group-addon">iban</span>
                          <g:textField name="iban" value="${params.iban}" id="iban" name="iban" class="form-control" placeholder="Filtrar IBAN" type="text"/>
                        </div>
                        <p class="help-block"></p>
                      </div>
                    </div>

                    <!-- Prepended text-->
                    <div class="form-group">
                      <div class="col-lg-6 col-lg-offset-3 text-center">
                        <div class="input-group">
                          <span class="input-group-addon">edad</span>
                          <g:textField name="edad" value="${params.edad}" id="edad" name="edad" class="form-control" placeholder="Filtrar edad" type="text"/>
                        </div>

                      </div>
                    </div>

                    <!-- Button -->
                    <div class="form-group">
                      <div class="col-lg-6 col-lg-offset-3 text-center">
                        <g:submitButton name="buscarPersonas" class="buscarPersonas" value="Buscar" id="buscarPersonas" name="buscarPersonas" class="btn btn-primary"/>
                      </div>
                    </div>

                    </fieldset>
                    </g:form>
                    <!--/formulario-->

                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Cerrar</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->



<div ng-init='personasJSON = ${raw(personas_JSON)}'></div>



<div id="custom-toolbar" class="btn-group">
    <div class="form-inline" role="form">
        
        
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">nombre</div>
                <input class="form-control" ng-model="search.nombre" placeholder="Filtrar nombre">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">edad</div>
                <input class="form-control" ng-model="search.edad" placeholder="Filtrar edad">
            </div>
        </div>
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">IBAN</div>
                <input class="form-control" ng-model="search.iban" placeholder="Filtrar nombre">
            </div>
        </div>
        <!--div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">Exacto</div>
                    <div class="checkbox">
                           <input type="checkbox" class="form-control">
                    </div>
            </div>
        </div-->        
       <a class="btn btn-primary" href="#primary" data-toggle="modal"><i class="glyphicons-search"></i> Nueva búsqueda</a>
    </div>
</div>
<table class="table" data-toggle="table" data-search="true" data-show-refresh="true" data-show-toggle="true" data-show-columns="true" data-toolbar="#toolbar">

<export:formats formats="['csv', 'excel', 'pdf', 'rtf', 'xml']" />

    <thead>
        <tr>
          <g:sortableColumn data-field="nombre" property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />
          <g:sortableColumn data-field="edad" property="edad" title="${message(code: 'persona.edad.label', default: 'Edad')}" />
          <g:sortableColumn data-field="iban" property="iban" title="${message(code: 'persona.iban.label', default: 'Iban')}" />
        </tr>
    </thead>
          <tbody>
                <tr ng-repeat="personaObj in personasJSON | filter:search:strict">
                  <td>{{personaObj.nombre}}</td>
                  <td>{{personaObj.edad}}</td>
                  <td>{{personaObj.iban}}</td>
                </tr>
          </tbody>
</table>

      <ul class="pagination" >
        <g:paginate 
                    action="buscarPersonas"
                    total="${personaInstanceCount ?: 0}"
                    params="${params}"
        />
      </ul>
      
</body>
</html>