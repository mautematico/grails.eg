<%@ page import="com.mx.eglobal.Persona" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Buscar personas</title>
  <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0-rc.2/angular.min.js"></script>  
</head>
<body ng-app="">


<fieldset class="form">
    <g:form action="buscarPersonas" method="GET">
        <div class="fieldcontain">
            <label for="nombre">Filtrar nombre:</label>
            <g:textField name="nombre" value="${params.nombre}"/>
            <label for="edad">Filtrar edad:</label>
            <g:textField name="edad" value="${params.edad}"/>
            <label for="iban">Filtrar iban:</label>
            <g:textField name="iban" value="${params.iban}"/>
        </div>
        <fieldset class="buttons">
          <g:submitButton name="buscarPersonas" class="buscarPersonas" value="Buscar" />
        </fieldset>
    </g:form>
</fieldset>



<div ng-init='personasJSON = ${raw(personas_JSON)}'></div>

<label>Exacto <input type="checkbox" ng-model="strict"></label><br>

<table id="searchObjResults">
      <thead>
          <tr>
            <g:sortableColumn property="nombre" title="${message(code: 'persona.nombre.label', default: 'Nombre')}" />
            <g:sortableColumn property="edad" title="${message(code: 'persona.edad.label', default: 'Edad')}" />
            <g:sortableColumn property="iban" title="${message(code: 'persona.iban.label', default: 'Iban')}" />
          </tr>
          <tr>
            <input ng-model="search.$" placeholder="Filtrar cualquiera">
            <input ng-model="search.nombre" placeholder="Filtrar nombre">
            <input ng-model="search.edad" placeholder="Filtrar edad">
            <input ng-model="search.iban" placeholder="Filtrar IBAN">
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

      <div class="pagination">
        <g:paginate
                    action="buscarPersonas"
                    total="${personaInstanceCount ?: 0}"
                    params="${params}"
        />
      </div>
</body>
</html>