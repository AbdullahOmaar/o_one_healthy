
import android.content.Context
import android.view.View
import com.davemorrissey.labs.subscaleview.ImageSource
import com.davemorrissey.labs.subscaleview.SubsamplingScaleImageView
import com.imebra.BuildConfig
import com.imebra.CodecFactory
import com.imebra.StreamReader
import com.o_one_healthy.app.Utils
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.sql.DriverManager.println




internal class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) :
    PlatformView {
//    private val textView: TextView
//    private val button: Button
    private val image: SubsamplingScaleImageView

    override fun getView(): View {
        image.setPanLimit(SubsamplingScaleImageView.PAN_LIMIT_INSIDE)
        image.setMinimumScaleType(SubsamplingScaleImageView.SCALE_TYPE_CENTER_INSIDE)
        image.maxScale = 8.0f
        image.setDoubleTapZoomScale(5.0f)
        image.setDoubleTapZoomStyle(SubsamplingScaleImageView.ZOOM_FOCUS_CENTER)
        image.setDebug(BuildConfig.DEBUG)

        return image
    }

    override fun dispose() {

    }

    init {
        System.loadLibrary("imebra_lib")
        image = SubsamplingScaleImageView(context)
        CoroutineScope(Dispatchers.Main).launch {

        val file = Utils.getNetworkFile(context, "${creationParams?.get("url")}","MAR.DCM")

        val loadedDataSet = CodecFactory.load(file.absolutePath ,2048)
        val image2 = loadedDataSet.getImageApplyModalityTransform(0)
        val colorSpace = image2.colorSpace
        val width = image2.width
        val height = image2.height
        val chain = Utils.applyTransformation(
            colorSpace, loadedDataSet,
            image2, width, height
        )

        image.setImage(ImageSource.bitmap(Utils.generateBitmap(chain, image2)!!))}
    }
/*        val file = Utils.getFile(context, "MRBRAIN.DCM")

val loadedDataSet = com.imebra.CodecFactory
    .load(file.absolutePath, 2048)
val image = loadedDataSet.getImageApplyModalityTransform(0)*/
/*
*//*        val loadedDataSet = com.imebra.CodecFactory
    .load(file.absolutePath, 2048)*//*

*//*

// Retrieve the first image (index = 0)
val image = loadedDataSet.getImageApplyModalityTransform(0)

// Get the color space
val colorSpace = image.colorSpace

// Get the size in pixels
val width = image.width
val height = image.height*//*
*//*        val chain = Utils.applyTransformation(colorSpace, loadedDataSet,
        image, width, height)*//*
image.setPanLimit(SubsamplingScaleImageView.PAN_LIMIT_INSIDE)
image.setMinimumScaleType(SubsamplingScaleImageView.SCALE_TYPE_CENTER_INSIDE)
image.maxScale = 8.0f
image.setDoubleTapZoomScale(5.0f)
image.setDoubleTapZoomStyle(SubsamplingScaleImageView.ZOOM_FOCUS_CENTER)
image.setDebug(BuildConfig.DEBUG)*/
//        renderImage.setImage(ImageSource.bitmap(Utils.generateBitmap(chain, image)!!))


}

