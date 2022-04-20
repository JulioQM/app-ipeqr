var changeAnimationDuration = 500;
var resizeAnimationDuration = 1000;

function Marker(poiData) {

    this.poiData = poiData;
    this.isSelected = false;
    this.animationGroupIdle = null;
    this.animationGroupSelected = null;

    // boton color azul oscuro
    this.markerDrawableIdle = new AR.ImageDrawable(World.markerDrawableIdle, 1.5, {
        zOrder: 0,
        opacity: 1.0,
        translate: {
            y: -7
        },

        onClick: Marker.prototype.getOnClickTrigger(this)
    });

    //  boton color azul opaco
    this.markerDrawableSelected = new AR.ImageDrawable(World.markerDrawableSelected, 1.5, {
        zOrder: 0,
        opacity: 0.0,
        translate: {
            y: -7
        },
        onClick: null
    });
    // desde aqui empieza mi mundo con componentes AR
    var enlace_imagen = new AR.ImageResource(poiData.foto);
    this.fotografia = new AR.ImageDrawable(enlace_imagen, 3.5, {
        verticalAnchor: AR.CONST.VERTICAL_ANCHOR.BOTTOM,
        translate: { // permite subir modelo AR + y para bajar -
            y: -2.5
        },
    });
    var etiquetaPersonal = new AR.Label("Datos personales", 0.65, {
        zOrder: 1,
        translate: {
            y: -2.8
        },
        style: {
            textColor: '#FFFFFF',
            fontStyle: AR.CONST.FONT_STYLE.BOLD
        }
    });
    this.nombres = new AR.Label(poiData.nombre + " " + poiData.apellido, 0.6, {
        zOrder: 1,
        translate: {
            y: -3.4
        },
        style: {
            textColor: '#1cffd5',
            /* fontStyle: AR.CONST.FONT_STYLE.BOLD */
        }
    });
    this.ciudad = new AR.Label(poiData.ciudad, 0.6, {
        zOrder: 1,
        translate: {
            y: -4.0
        },
        style: {
            textColor: '#1cffd5',
            /* fontStyle: AR.CONST.FONT_STYLE.BOLD */
        }
    });
    this.etiquetaFamiliar = new AR.Label("Datos familiares", 0.65, {
        zOrder: 1,
        translate: {
            y: -4.6
        },
        style: {
            textColor: '#FFFFFF',
            fontStyle: AR.CONST.FONT_STYLE.BOLD
        }
    });
    this.nombreFamiliar = new AR.Label(poiData.nombreFamiliar, 0.65, {
        zOrder: 1,
        translate: {
            y: -5.2
        },
        style: {
            textColor: '#1cffd5',
            /*   fontStyle: AR.CONST.FONT_STYLE.BOLD */
        }
    });
    this.celularFamiliar = new AR.Label(poiData.telefonoFamiliar, 0.65, {
        zOrder: 1,
        translate: {
            y: -5.8
        },
        style: {
            textColor: '#1cffd5', //#ffd103 color amarillo
            /*   fontStyle: AR.CONST.FONT_STYLE.BOLD */
        }
    });
    /* Create an AR.Label for the marker's title . */
    this.titleLabel = new AR.Label( /* poiData.mensaje */ "Mostrar", 0.4, {
        zOrder: 1,
        translate: {
            y: -6.9
        },
        style: {
            textColor: '#FFFFFF',
            fontStyle: AR.CONST.FONT_STYLE.BOLD
        }
    });

    this.descriptionLabel = new AR.Label("más", 0.4, {
        zOrder: 1,
        translate: {
            y: -7.2
        },
        style: {
            textColor: '#FFFFFF',
            fontStyle: AR.CONST.FONT_STYLE.BOLD
        }
    });


    this.directionIndicatorDrawable = new AR.ImageDrawable(World.markerDrawableDirectionIndicator, 0.1, {
        verticalAnchor: AR.CONST.VERTICAL_ANCHOR.TOP
    });
    var markerLocation = new AR.RelativeLocation(null, 5, 0, 1);
    this.markerObject = new AR.GeoObject(markerLocation, {
        drawables: {
            cam: [this.markerDrawableIdle, this.markerDrawableSelected, this.titleLabel, this.descriptionLabel, this.fotografia, etiquetaPersonal, this.nombres, this.ciudad, this.etiquetaFamiliar, this.nombreFamiliar, this.celularFamiliar],
            indicator: this.directionIndicatorDrawable
        }
    });

    return this;
}

Marker.prototype.getOnClickTrigger = function(marker) {

    /*
        The setSelected and setDeselected functions are prototype Marker functions.

        Both functions perform the same steps but inverted, hence only one function (setSelected) is covered in
        detail. Three steps are necessary to select the marker. First the state will be set appropriately. Second
        the background drawable will be enabled and the standard background disabled. This is done by setting the
        opacity property to 1.0 for the visible state and to 0.0 for an invisible state. Third the onClick function
        is set only for the background drawable of the selected marker.
    */

    return function() {

        if (!Marker.prototype.isAnyAnimationRunning(marker)) {
            if (marker.isSelected) {

                Marker.prototype.setDeselected(marker);

            } else {
                Marker.prototype.setSelected(marker);
                try {
                    World.onMarkerSelected(marker);
                } catch (err) {
                    alert(err);
                }

            }
        } else {
            AR.logger.debug('a animation is already running');
        }

        return true;
    };
};

/*
    Property Animations allow constant changes to a numeric value/property of an object, dependent on start-value,
    end-value and the duration of the animation. Animations can be seen as functions defining the progress of the
    change on the value. The Animation can be parametrized via easing curves.
*/
Marker.prototype.setSelected = function(marker) {

    marker.isSelected = true;

    /* New: . */
    if (marker.animationGroupSelected === null) {
        var easingCurve = new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
            amplitude: 2.0
        });

        /* Create AR.PropertyAnimation that animates the opacity to 0.0 in order to hide the idle-state-drawable. */
        var hideIdleDrawableAnimation = new AR.PropertyAnimation(
            marker.markerDrawableIdle, "opacity", null, 0.0, changeAnimationDuration);
        /* Create AR.PropertyAnimation that animates the opacity to 1.0 in order to show the selected-state-drawable. */
        var showSelectedDrawableAnimation = new AR.PropertyAnimation(
            marker.markerDrawableSelected, "opacity", null, 1.0, changeAnimationDuration);

        /* Create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.2. */
        var idleDrawableResizeAnimationX = new AR.PropertyAnimation(
            marker.markerDrawableIdle, 'scale.x', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.2. */
        var selectedDrawableResizeAnimationX = new AR.PropertyAnimation(
            marker.markerDrawableSelected, 'scale.x', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the title label to 1.2. */
        var titleLabelResizeAnimationX = new AR.PropertyAnimation(
            marker.titleLabel, 'scale.x', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the description label to 1.2. */
        var descriptionLabelResizeAnimationX = new AR.PropertyAnimation(
            marker.descriptionLabel, 'scale.x', null, 1.2, resizeAnimationDuration, easingCurve);

        /* Create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.2. */
        var idleDrawableResizeAnimationY = new AR.PropertyAnimation(
            marker.markerDrawableIdle, 'scale.y', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.2. */
        var selectedDrawableResizeAnimationY = new AR.PropertyAnimation(
            marker.markerDrawableSelected, 'scale.y', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the title label to 1.2. */
        var titleLabelResizeAnimationY = new AR.PropertyAnimation(
            marker.titleLabel, 'scale.y', null, 1.2, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the description label to 1.2. */
        var descriptionLabelResizeAnimationY = new AR.PropertyAnimation(
            marker.descriptionLabel, 'scale.y', null, 1.2, resizeAnimationDuration, easingCurve);

        /*
            There are two types of AR.AnimationGroups. Parallel animations are running at the same time,
            sequentials are played one after another. This example uses a parallel AR.AnimationGroup.
        */
        marker.animationGroupSelected = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [
            hideIdleDrawableAnimation,
            showSelectedDrawableAnimation,
            idleDrawableResizeAnimationX,
            selectedDrawableResizeAnimationX,
            titleLabelResizeAnimationX,
            descriptionLabelResizeAnimationX,
            idleDrawableResizeAnimationY,
            selectedDrawableResizeAnimationY,
            titleLabelResizeAnimationY,
            descriptionLabelResizeAnimationY
        ]);
    }

    /* Removes function that is set on the onClick trigger of the idle-state marker. */
    marker.markerDrawableIdle.onClick = null;
    /* Sets the click trigger function for the selected state marker. */
    marker.markerDrawableSelected.onClick = Marker.prototype.getOnClickTrigger(marker);

    /* Enables the direction indicator drawable for the current marker. */
    /* marker.directionIndicatorDrawable.enabled = true; */
    /* Starts the selected-state animation. */
    marker.animationGroupSelected.start();
};

Marker.prototype.setDeselected = function(marker) {

    marker.isSelected = false;

    if (marker.animationGroupIdle === null) {
        var easingCurve = new AR.EasingCurve(AR.CONST.EASING_CURVE_TYPE.EASE_OUT_ELASTIC, {
            amplitude: 2.0
        });

        /* Create AR.PropertyAnimation that animates the opacity to 1.0 in order to show the idle-state-drawable. */
        var showIdleDrawableAnimation = new AR.PropertyAnimation(
            marker.markerDrawableIdle, "opacity", null, 1.0, changeAnimationDuration);
        /* Create AR.PropertyAnimation that animates the opacity to 0.0 in order to hide the selected-state-drawable. */
        var hideSelectedDrawableAnimation = new AR.PropertyAnimation(
            marker.markerDrawableSelected, "opacity", null, 0, changeAnimationDuration);
        /* Create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.0. */
        var idleDrawableResizeAnimationX = new AR.PropertyAnimation(
            marker.markerDrawableIdle, 'scale.x', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.0. */
        var selectedDrawableResizeAnimationX = new AR.PropertyAnimation(
            marker.markerDrawableSelected, 'scale.x', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the title label to 1.0. */
        var titleLabelResizeAnimationX = new AR.PropertyAnimation(
            marker.titleLabel, 'scale.x', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the description label to 1.0. */
        var descriptionLabelResizeAnimationX = new AR.PropertyAnimation(
            marker.descriptionLabel, 'scale.x', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the idle-state-drawable to 1.0. */
        var idleDrawableResizeAnimationY = new AR.PropertyAnimation(
            marker.markerDrawableIdle, 'scale.y', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the selected-state-drawable to 1.0. */
        var selectedDrawableResizeAnimationY = new AR.PropertyAnimation(
            marker.markerDrawableSelected, 'scale.y', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the title label to 1.0. */
        var titleLabelResizeAnimationY = new AR.PropertyAnimation(
            marker.titleLabel, 'scale.y', null, 1.0, resizeAnimationDuration, easingCurve);
        /* Create AR.PropertyAnimation that animates the scaling of the description label to 1.0. */
        var descriptionLabelResizeAnimationY = new AR.PropertyAnimation(
            marker.descriptionLabel, 'scale.y', null, 1.0, resizeAnimationDuration, easingCurve);

        /*
            There are two types of AR.AnimationGroups. Parallel animations are running at the same time,
            sequentials are played one after another. This example uses a parallel AR.AnimationGroup.
        */
        marker.animationGroupIdle = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [
            showIdleDrawableAnimation,
            hideSelectedDrawableAnimation,
            idleDrawableResizeAnimationX,
            selectedDrawableResizeAnimationX,
            titleLabelResizeAnimationX,
            descriptionLabelResizeAnimationX,
            idleDrawableResizeAnimationY,
            selectedDrawableResizeAnimationY,
            titleLabelResizeAnimationY,
            descriptionLabelResizeAnimationY
        ]);
    }

    /* Sets the click trigger function for the idle state marker. */
    marker.markerDrawableIdle.onClick = Marker.prototype.getOnClickTrigger(marker);
    /* Removes function that is set on the onClick trigger of the selected-state marker. */
    marker.markerDrawableSelected.onClick = null;

    /* Disables the direction indicator drawable for the current marker. */
    /*  marker.directionIndicatorDrawable.enabled = false; */
    /* Starts the idle-state animation. */
    marker.animationGroupIdle.start();
};

Marker.prototype.isAnyAnimationRunning = function(marker) {

    if (marker.animationGroupIdle === null || marker.animationGroupSelected === null) {
        return false;
    } else {
        return marker.animationGroupIdle.isRunning() === true || marker.animationGroupSelected.isRunning() === true;
    }
};