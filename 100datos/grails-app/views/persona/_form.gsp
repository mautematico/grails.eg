<%@ page import="com.mx.eglobal.Persona" %>



<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'edad', 'error')} required">
	<label for="edad">
		<g:message code="persona.edad.label" default="Edad" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="edad" type="number" value="${personaInstance.edad}" required=""/>

</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'iban', 'error')} required">
	<label for="iban">
		<g:message code="persona.iban.label" default="Iban" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="iban" required="" value="${personaInstance?.iban}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: personaInstance, field: 'nombre', 'error')} required">
	<label for="nombre">
		<g:message code="persona.nombre.label" default="Nombre" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nombre" required="" value="${personaInstance?.nombre}"/>

</div>

