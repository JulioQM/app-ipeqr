var World = {
    // creo parametros para mis datos traidos desde dart
    persid: "",
    nombre: "",
    cedula: "",
    apellido: "",
    genero: "",
    localidad: "",
    direccion: "",
    telefonoFamiliar: "",
    nombreFamiliar: "",
    enfermedad: "",
    foto: "",
    markerList: [],
    /* True once data was fetched. */
    initiallyLoadedData: false,
    /* Different POI-Marker assets. */
    markerDrawableIdle: null,
    markerDrawableSelected: null,
    markerDrawableDirectionIndicator: null,
    /* the last selected marker. */
    currentMarker: null,
    loaded: false,
    /* Called to inject new POI data. */
    init: function unitFn() {

        if (World.loaded === false) {
            setTimeout(function() {
                document.getElementById("loadingMessage").innerHTML = "Loading ...";
                var e = document.getElementById('loadingMessage');
                e.parentElement.removeChild(e);
            }, 4700);
        }
    },
    worldLoaded: function worldLoadedFn() {
        document.getElementById("loadingMessage").innerHTML = "tom..asa.sa.s...";
        World.loaded = true;

    },
    handleValueFromQR: function handleValueFromQRFn(persid, nombre, apellido, cedula, genero, localidad, direccion, telefonoFamiliar, nombreFamiliar, enfermedad, foto) {
        // valores traidos desde dart con funcion de javascript
        this.persid += persid;
        this.nombre += nombre;
        this.apellido += apellido;
        this.cedula += cedula;
        this.genero += genero;
        this.localidad += localidad;
        this.direccion += direccion;
        this.telefonoFamiliar += telefonoFamiliar;
        this.nombreFamiliar += nombreFamiliar;
        this.enfermedad += enfermedad;
        this.foto += foto;
        return nombre;
    },
    loadPoisFromJsonData: function loadPoisFromJsonDataFn(poiData) {
        // son imagenes que seran utilizados para el efecto del boton AR
        World.markerDrawableIdle = new AR.ImageResource("assets/marker_idles.png", {
            onError: World.onError
        });
        World.markerDrawableSelected = new AR.ImageResource("assets/marker_selecteds.png", {
            onError: World.onError
        });
        World.markerDrawableDirectionIndicator = new AR.ImageResource("assets/indi.png", {
            onError: World.onError
        });

        // funcion para convertir los nombres en Upercamercase
        function letras(frase) {
            // nombres sin modificar
            let nombres = frase;
            // nombre todo minuscula
            let minuscula = nombres.toLowerCase();
            // separacion de palabras
            let separacion = minuscula.split(" ");
            // funcion mayuscula primera letra
            let mayus = separacion.map(palabra => {
                return palabra[0].toUpperCase() + palabra.slice(1);
            });
            // resultado union de palabras
            let union = mayus.join(" ");
            return union;
        }
        // creando variables upercamercase
        var convertirNombre = letras(this.nombre);
        var convertirApellido = letras(this.apellido);
        var convertirNombreFamiliar = letras(this.nombreFamiliar);
        var convertirCiudad = (this.localidad.toLowerCase()).replace(/\b\w/g, l => l.toUpperCase());
        // función para que aparesca un nombre y un apellido
        var nombref = convertirNombreFamiliar;
        var resul = nombref.split(" ");
        if (resul.length >= 4) {
            nomFamilia = resul[0] + " " + resul[2];
            console.log('............1..............');
            console.log(nomFamilia);
            console.log('..........................');
        } else {
            nomFamilia = resul.join(" ");
            console.log('..............2............');
            console.log(nomFamilia);
            console.log('..........................');
        }


        // creando variables para ir al mundo AR
        var nombre = (convertirNombre).split(' ')[0];
        var apellido = (convertirApellido).split(' ')[0];
        var cedula = this.cedula;
        var genero = this.genero;
        var ciudad = convertirCiudad;
        var direccion = this.direccion;
        var nombreFamiliar = /* convertirNombreFamiliar */ nomFamilia;
        var telefonoFamiliar = this.telefonoFamiliar;
        var foto = this.foto;

        var poiData = {
            "mensaje": "Mostrar",
            "nombre": nombre,
            "apellido": apellido,
            "cedula": cedula,
            "genero": genero,
            "ciudad": ciudad,
            "direccion": direccion,
            "nombreFamiliar": nombreFamiliar,
            "telefonoFamiliar": telefonoFamiliar,
            "foto": foto


        }
        World.markerList.push(new Marker(poiData));
        /* var marker = new Marker(poiData); */
    },

    locationChanged: function locationChangedFn(lat = null, lon = 5, alt = 0, acc = 1) {
        World.markerList = [];
        if (!World.initiallyLoadedData) {

            var informacion = {
                "mensaje": "Mostrar",
                "nombre": this.nombres,
                "apellido": this.apellidos,
                "cedula": this.cedula,
                "genero": this.genero,
                "ciudad": this.localidad,
                "direccion": this.direccion,
                "telefonoFamiliar": this.telefonoFamiliar

            }
            World.initiallyLoadedData = true;
        }
    },

    /* Fired when user pressed maker in cam. */
    onMarkerSelected: function onMarkerSelectedFn(marker) {
        /// consumiendo datos desde javascript tipo get usando fecth
        /* let id = 1; */
        const url = `https://api-rest-lookhere-produccion.herokuapp.com/api/lookhere/familiarIdPersona/${this.persid}`;
        fetch(url)
            .then(response => response.json())
            .then(data => mostrarData(data))
            .catch(err => console.log(err));
        const mostrarData = (data) => {
            var array = data['familiar'];
            var famil = '';
            for (var i = 0; i < array.length; i++) {
                famil += `<tr> 
                <td class="colorsBlack"> ${letra(array[i]['famil_nombres']+' '+array[i]['famil_apellidos'])}</td>
                <td class="colorsBlack">${array[i]['famil_celular']}</td>
                <td id="centrar"> <a title="Llamada" href="tel:${array[i]['famil_celular']}"><img src="assets/telephone-call.png" alt="Llamada" width="30px" /></a></td>
                </tr>`;
            }
            document.getElementById('data').innerHTML = famil;
        }

        // funcion para convertir los nombres en Upercamercase
        function letra(frase) {
            // nombres sin modificar
            let nombres = frase;
            // nombre todo minuscula
            let minuscula = nombres.toLowerCase();
            // separacion de palabras
            let separacion = minuscula.split(" ");
            // funcion mayuscula primera letra
            let mayus = separacion.map(palabra => {
                return palabra[0].toUpperCase() + palabra.slice(1);
            });
            // resultado union de palabras
            let union = mayus.join(" ");
            return union;
        }

        // AR cerrar vista desplegable
        World.closePanel();
        World.currentMarker = marker;
        // creando variables para llamar valor
        var ciudadConvertir = this.localidad.toLowerCase();
        var nombres = letra(this.nombre);
        var apellidos = letra(this.apellido);
        var cedula = this.cedula;
        var genero = this.genero;
        var ciudad = ciudadConvertir.replace(/\b\w/g, l => l.toUpperCase());
        var direccion = letra(this.direccion);
        var telefono = this.telefonoFamiliar;
        var enfermedad = letra(this.enfermedad);

        document.getElementById("poiDetailNombre").innerHTML = nombres;
        document.getElementById("poiDetailApellido").innerHTML = apellidos;
        document.getElementById("poiDetailCedula").innerHTML = cedula;
        document.getElementById("poiDetailGenero").innerHTML = genero;
        document.getElementById("poiDetailCiudad").innerHTML = ciudad;
        document.getElementById("poiDetailDireccion").innerHTML = direccion;
        /* document.getElementById("poiDetailTelefono").innerHTML = telefono; */
        document.getElementById("poiDetailEnfermedad").innerHTML = enfermedad;

        /* Show panel. */
        // AR abrir vista desplegable
        document.getElementById("panelPoiDetail").style.visibility = "visible";

    },

    // funcion de panel desplegable
    closePanel: function closePanel() {
        /* Hide panel. */
        document.getElementById("panelPoiDetail").style.visibility = "hidden";

        if (World.currentMarker != null) {
            /* Deselect AR-marker when user exits detail screen div. */
            World.currentMarker.setDeselected(World.currentMarker);
            World.currentMarker = null;
        }
    },

    /* Screen was clicked but no geo-object was hit. */
    // Funcion de click afuera para salir de la vista desplegable
    onScreenClick: function onScreenClickFn() {
        /* You may handle clicks on empty AR space too. */
        World.closePanel();
    },

    onError: function onErrorFn(error) {
        alert(error);
    }
};
World.init();

/* Forward locationChanges to custom function. */
AR.context.onLocationChanged = World.locationChanged;

/* Forward clicks in empty area to World. */
AR.context.onScreenClick = World.onScreenClick;