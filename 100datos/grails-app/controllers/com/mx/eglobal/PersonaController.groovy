package com.mx.eglobal



import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import grails.converters.JSON
import org.codehaus.groovy.grails.web.json.*

@Transactional(readOnly = true)
class PersonaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Persona.list(params), model:[personaInstanceCount: Persona.count()]
    }
    def buscarPersonas(Integer max) {
        params.max = Math.min(params.max ? params.int('max') : 100, 100)
        
        def lista = Persona.createCriteria().list (params) {
               if ( params.nombre ) {
                   ilike("nombre", "%${params.nombre}%")
               }
               if ( params.edad ) {
                     between("edad", Integer.parseInt(params.edad), Integer.parseInt(params.edad))
               }
               if ( params.iban ) {
                   ilike("iban", "%${params.iban}%")
               }
            }
        
        def lista_json = (lista as JSON).toString()
        [personas_JSON:lista_json, personaInstanceCount: lista.totalCount, params: params]
    }
    def personasJSON(){
        def personas = Persona.getAll();
        render personas as JSON;
    }
    def histogramaEdades(){        
        personasJSON();
    }

    def show(Persona personaInstance) {
        respond personaInstance
    }

    def create() {
        respond new Persona(params)
    }

    @Transactional
    def save(Persona personaInstance) {
        if (personaInstance == null) {
            notFound()
            return
        }

        if (personaInstance.hasErrors()) {
            respond personaInstance.errors, view:'create'
            return
        }

        personaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'persona.label', default: 'Persona'), personaInstance.id])
                redirect personaInstance
            }
            '*' { respond personaInstance, [status: CREATED] }
        }
    }

    def edit(Persona personaInstance) {
        respond personaInstance
    }

    @Transactional
    def update(Persona personaInstance) {
        if (personaInstance == null) {
            notFound()
            return
        }

        if (personaInstance.hasErrors()) {
            respond personaInstance.errors, view:'edit'
            return
        }

        personaInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Persona.label', default: 'Persona'), personaInstance.id])
                redirect personaInstance
            }
            '*'{ respond personaInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Persona personaInstance) {

        if (personaInstance == null) {
            notFound()
            return
        }

        personaInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Persona.label', default: 'Persona'), personaInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'persona.label', default: 'Persona'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
