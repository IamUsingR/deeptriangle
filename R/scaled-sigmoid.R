ScaledSigmoid <- R6::R6Class(
  "ScaledSigmoid",
  inherit = keras::KerasLayer,
  public = list(
    scale = NULL,
    build = function(input_shape) {
      self$scale <- self$add_weight(
        name = 'scale',
        shape = list(input_shape[[2]], 1L),
        initializer = keras::initializer_random_normal(mean = 1),
        trainable = TRUE
      )
    },
    call = function(x, mask = NULL) {
      keras::k_sigmoid(x) * self$scale
    }
  )
)

#' Scaled sigmoid activation
#'
#' @param object Model or layer object
#' @param name 	An optional name string for the layer. Should be unique in a model
#'   (do not reuse the same name twice). It will be autogenerated if it isn't provided.
#' @param trainable Whether the layer weights will be updated during training.
#' @export
dt_activation_scaled_sigmoid <- function(object, name = NULL, trainable = TRUE) {
  keras::create_layer(ScaledSigmoid, object, list(
    name = name,
    trainable = trainable
  ))
}
