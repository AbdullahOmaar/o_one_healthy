package com.o_one_healthy.app


import android.content.Context
import android.graphics.Bitmap
import android.os.Environment
import android.util.Log
import com.imebra.*
import java.io.*
import java.net.HttpURLConnection
import java.net.URL
import java.nio.ByteBuffer
import java.util.*
import kotlinx.coroutines.Dispatchers.IO
import kotlinx.coroutines.Dispatchers.Main
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import kotlinx.coroutines.*


object Utils {



        suspend fun getNetworkFile(context: Context, fileUrl: String, fileName: String): File=withContext(
            Dispatchers.Default) {
        var input: InputStream? = null
        var output: OutputStream? = null
        var connection: HttpURLConnection? = null
        val file = File("${getPath()}${File.separator}$fileName")

        val url = URL(fileUrl)

        try{
            file.createNewFile()
            connection = url.openConnection() as HttpURLConnection?

            connection?.connect()
            val fileLength = connection!!.contentLength

            // download the file

            // download the file
            input = connection.inputStream

            output = FileOutputStream(file)

            val data = ByteArray(4096)
            val total: Long = 0
            var count: Int
            while (true) {
                val n = input.read(data, 0, 4096)
                if (n <= 0) {
                    break
                }
                output.write(data, 0, n)
            }
            output.close()
        } catch (e: IOException) {
            Log.d("Test", "error")
        } catch (t: Throwable) {
            Log.d("Test", "error $t")

//            output.close()
        }
            return@withContext file

    }
    fun getPath(): String = StringBuilder(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS).absolutePath)
        .toString()
    fun getFile(context: Context, fileName: String): File {

        val file = File(fileName)
        if (!file.exists()) {
            var ops: OutputStream? = null
            try {
                file.createNewFile()
                val ips = context.assets.open("0002.DCM")
                ops = BufferedOutputStream(FileOutputStream(file))
                val buffer = ByteArray(4096)
                while (true) {
                    val n = ips.read(buffer, 0, 4096)
                    if (n <= 0) {
                        break
                    }
                    ops.write(buffer, 0, n)
                }
                ops.close()
            } catch (e: IOException) {
                Log.d("Test", "error")
            } catch (t: Throwable) {
                ops?.close()
            }
        }
        return file
    }

    fun generateBitmap(chain: TransformsChain, image: Image): Bitmap? {
        // We create a DrawBitmap that always apply the chain transform before getting the RGB image
        val draw = com.imebra.DrawBitmap(chain)

        // Ask for the size of the buffer (in bytes)
        val requestedBufferSize = draw.getBitmap(image, drawBitmapType_t.drawBitmapRGBA,
            4, ByteArray(0))
        // Ideally you want to reuse this in subsequent calls to getBitmap()
        val buffer = ByteArray(requestedBufferSize.toInt())
        val byteBuffer = ByteBuffer.wrap(buffer)
        // Now fill the buffer with the image data and create a bitmap from it
        draw.getBitmap(image, drawBitmapType_t.drawBitmapRGBA, 4, buffer)
        val renderBitmap = Bitmap.createBitmap(image.width.toInt(),
            image.height.toInt(), Bitmap.Config.ARGB_8888)
        renderBitmap.copyPixelsFromBuffer(byteBuffer)
        return renderBitmap
    }

    fun applyTransformation(colorSpace: String?,
                            loadedDataSet: DataSet,
                            image: Image,
                            width: Long,
                            height: Long): TransformsChain {
        // The transforms chain will contain all the transform that we want to
        // apply to the image before displaying it
        val chain = TransformsChain()

        if (com.imebra.ColorTransformsFactory.isMonochrome(colorSpace)) {
            // Allocate a VOILUT transform. If the DataSet does not contain any pre-defined
            //  settings then we will find the optimal ones.
            val voilutTransform = VOILUT()
            // Retrieve the VOIs (center/width pairs)
            val vois = loadedDataSet.voIs

            // Retrieve the LUTs
            val luts = ArrayList<LUT>()

            var scanLUTs: Long = 0
            while (true) {
                try {
                    luts.add(loadedDataSet.getLUT(com.imebra.TagId(0x0028,
                        0x3010), scanLUTs))
                } catch (e: Exception) {
                    break
                }
                scanLUTs++
            }
            if (!vois.isEmpty) {
                voilutTransform.setCenterWidth(vois.get(0).center, vois.get(0).width)
            } else if (!luts.isEmpty()) {
                voilutTransform.setLUT(luts[0])
            } else {
                voilutTransform.applyOptimalVOI(image, 0, 0, width, height)
            }
            chain.addTransform(voilutTransform)
        }
        return chain
    }
}
