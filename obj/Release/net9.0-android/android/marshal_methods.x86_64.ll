; ModuleID = 'marshal_methods.x86_64.ll'
source_filename = "marshal_methods.x86_64.ll"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [161 x ptr] zeroinitializer, align 16

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [483 x i64] [
	i64 u0x0071cf2d27b7d61e, ; 0: lib_Xamarin.AndroidX.SwipeRefreshLayout.dll.so => 79
	i64 u0x0189e6f888271174, ; 1: AsyncAwaitBestPractices.dll => 35
	i64 u0x02123411c4e01926, ; 2: lib_Xamarin.AndroidX.Navigation.Runtime.dll.so => 75
	i64 u0x022e81ea9c46e03a, ; 3: lib_CommunityToolkit.Maui.Core.dll.so => 37
	i64 u0x02abedc11addc1ed, ; 4: lib_Mono.Android.Runtime.dll.so => 159
	i64 u0x032267b2a94db371, ; 5: lib_Xamarin.AndroidX.AppCompat.dll.so => 58
	i64 u0x043032f1d071fae0, ; 6: ru/Microsoft.Maui.Controls.resources => 24
	i64 u0x044440a55165631e, ; 7: lib-cs-Microsoft.Maui.Controls.resources.dll.so => 2
	i64 u0x046eb1581a80c6b0, ; 8: vi/Microsoft.Maui.Controls.resources => 30
	i64 u0x0517ef04e06e9f76, ; 9: System.Net.Primitives => 118
	i64 u0x051a3be159e4ef99, ; 10: Xamarin.GooglePlayServices.Tasks => 86
	i64 u0x0565d18c6da3de38, ; 11: Xamarin.AndroidX.RecyclerView => 77
	i64 u0x0581db89237110e9, ; 12: lib_System.Collections.dll.so => 96
	i64 u0x05989cb940b225a9, ; 13: Microsoft.Maui.dll => 49
	i64 u0x06076b5d2b581f08, ; 14: zh-HK/Microsoft.Maui.Controls.resources => 31
	i64 u0x06388ffe9f6c161a, ; 15: System.Xml.Linq.dll => 151
	i64 u0x0680a433c781bb3d, ; 16: Xamarin.AndroidX.Collection.Jvm => 61
	i64 u0x07c57877c7ba78ad, ; 17: ru/Microsoft.Maui.Controls.resources.dll => 24
	i64 u0x07dcdc7460a0c5e4, ; 18: System.Collections.NonGeneric => 94
	i64 u0x08a7c865576bbde7, ; 19: System.Reflection.Primitives => 133
	i64 u0x08f3c9788ee2153c, ; 20: Xamarin.AndroidX.DrawerLayout => 66
	i64 u0x0919c28b89381a0b, ; 21: lib_Microsoft.Extensions.Options.dll.so => 44
	i64 u0x092266563089ae3e, ; 22: lib_System.Collections.NonGeneric.dll.so => 94
	i64 u0x098b50f911ccea8d, ; 23: lib_Xamarin.GooglePlayServices.Basement.dll.so => 84
	i64 u0x09d144a7e214d457, ; 24: System.Security.Cryptography => 141
	i64 u0x0abb3e2b271edc45, ; 25: System.Threading.Channels.dll => 147
	i64 u0x0b3b632c3bbee20c, ; 26: sk/Microsoft.Maui.Controls.resources => 25
	i64 u0x0b6aff547b84fbe9, ; 27: Xamarin.KotlinX.Serialization.Core.Jvm => 89
	i64 u0x0be2e1f8ce4064ed, ; 28: Xamarin.AndroidX.ViewPager => 80
	i64 u0x0c3ca6cc978e2aae, ; 29: pt-BR/Microsoft.Maui.Controls.resources => 21
	i64 u0x0c3dd9438f54f672, ; 30: lib_Xamarin.GooglePlayServices.Maps.dll.so => 85
	i64 u0x0c59ad9fbbd43abe, ; 31: Mono.Android => 160
	i64 u0x0c7790f60165fc06, ; 32: lib_Microsoft.Maui.Essentials.dll.so => 50
	i64 u0x0e14e73a54dda68e, ; 33: lib_System.Net.NameResolution.dll.so => 116
	i64 u0x0f5e7abaa7cf470a, ; 34: System.Net.HttpListener => 115
	i64 u0x102a31b45304b1da, ; 35: Xamarin.AndroidX.CustomView => 65
	i64 u0x10f6cfcbcf801616, ; 36: System.IO.Compression.Brotli => 108
	i64 u0x11a70d0e1009fb11, ; 37: System.Net.WebSockets.dll => 125
	i64 u0x123639456fb056da, ; 38: System.Reflection.Emit.Lightweight.dll => 132
	i64 u0x125b7f94acb989db, ; 39: Xamarin.AndroidX.RecyclerView.dll => 77
	i64 u0x13a01de0cbc3f06c, ; 40: lib-fr-Microsoft.Maui.Controls.resources.dll.so => 8
	i64 u0x13f1e5e209e91af4, ; 41: lib_Java.Interop.dll.so => 158
	i64 u0x13f1e880c25d96d1, ; 42: he/Microsoft.Maui.Controls.resources => 9
	i64 u0x143d8ea60a6a4011, ; 43: Microsoft.Extensions.DependencyInjection.Abstractions => 41
	i64 u0x1497051b917530bd, ; 44: lib_System.Net.WebSockets.dll.so => 125
	i64 u0x17125c9a85b4929f, ; 45: lib_netstandard.dll.so => 156
	i64 u0x17b56e25558a5d36, ; 46: lib-hu-Microsoft.Maui.Controls.resources.dll.so => 12
	i64 u0x17f9358913beb16a, ; 47: System.Text.Encodings.Web => 144
	i64 u0x18402a709e357f3b, ; 48: lib_Xamarin.KotlinX.Serialization.Core.Jvm.dll.so => 89
	i64 u0x18f0ce884e87d89a, ; 49: nb/Microsoft.Maui.Controls.resources.dll => 18
	i64 u0x19a4c090f14ebb66, ; 50: System.Security.Claims => 140
	i64 u0x1a91866a319e9259, ; 51: lib_System.Collections.Concurrent.dll.so => 92
	i64 u0x1aac34d1917ba5d3, ; 52: lib_System.dll.so => 155
	i64 u0x1aad60783ffa3e5b, ; 53: lib-th-Microsoft.Maui.Controls.resources.dll.so => 27
	i64 u0x1c753b5ff15bce1b, ; 54: Mono.Android.Runtime.dll => 159
	i64 u0x1e3d87657e9659bc, ; 55: Xamarin.AndroidX.Navigation.UI => 76
	i64 u0x1e71143913d56c10, ; 56: lib-ko-Microsoft.Maui.Controls.resources.dll.so => 16
	i64 u0x1ed8fcce5e9b50a0, ; 57: Microsoft.Extensions.Options.dll => 44
	i64 u0x1f055d15d807e1b2, ; 58: System.Xml.XmlSerializer => 154
	i64 u0x209375905fcc1bad, ; 59: lib_System.IO.Compression.Brotli.dll.so => 108
	i64 u0x20fab3cf2dfbc8df, ; 60: lib_System.Diagnostics.Process.dll.so => 103
	i64 u0x2174319c0d835bc9, ; 61: System.Runtime => 139
	i64 u0x21cc7e445dcd5469, ; 62: System.Reflection.Emit.ILGeneration => 131
	i64 u0x220fd4f2e7c48170, ; 63: th/Microsoft.Maui.Controls.resources => 27
	i64 u0x2347c268e3e4e536, ; 64: Xamarin.GooglePlayServices.Basement.dll => 84
	i64 u0x237be844f1f812c7, ; 65: System.Threading.Thread.dll => 148
	i64 u0x2407aef2bbe8fadf, ; 66: System.Console => 100
	i64 u0x240abe014b27e7d3, ; 67: Xamarin.AndroidX.Core.dll => 63
	i64 u0x247619fe4413f8bf, ; 68: System.Runtime.Serialization.Primitives.dll => 138
	i64 u0x252073cc3caa62c2, ; 69: fr/Microsoft.Maui.Controls.resources.dll => 8
	i64 u0x2662c629b96b0b30, ; 70: lib_Xamarin.Kotlin.StdLib.dll.so => 87
	i64 u0x268c1439f13bcc29, ; 71: lib_Microsoft.Extensions.Primitives.dll.so => 45
	i64 u0x273f3515de5faf0d, ; 72: id/Microsoft.Maui.Controls.resources.dll => 13
	i64 u0x2742545f9094896d, ; 73: hr/Microsoft.Maui.Controls.resources => 11
	i64 u0x2759af78ab94d39b, ; 74: System.Net.WebSockets => 125
	i64 u0x27b410442fad6cf1, ; 75: Java.Interop.dll => 158
	i64 u0x2801845a2c71fbfb, ; 76: System.Net.Primitives.dll => 118
	i64 u0x2a128783efe70ba0, ; 77: uk/Microsoft.Maui.Controls.resources.dll => 29
	i64 u0x2a3b095612184159, ; 78: lib_System.Net.NetworkInformation.dll.so => 117
	i64 u0x2a6458f5677d9968, ; 79: lib_Mopups.dll.so => 53
	i64 u0x2a6507a5ffabdf28, ; 80: System.Diagnostics.TraceSource.dll => 104
	i64 u0x2ad156c8e1354139, ; 81: fi/Microsoft.Maui.Controls.resources => 7
	i64 u0x2af298f63581d886, ; 82: System.Text.RegularExpressions.dll => 146
	i64 u0x2afc1c4f898552ee, ; 83: lib_System.Formats.Asn1.dll.so => 107
	i64 u0x2b148910ed40fbf9, ; 84: zh-Hant/Microsoft.Maui.Controls.resources.dll => 33
	i64 u0x2c8bd14bb93a7d82, ; 85: lib-pl-Microsoft.Maui.Controls.resources.dll.so => 20
	i64 u0x2cc9e1fed6257257, ; 86: lib_System.Reflection.Emit.Lightweight.dll.so => 132
	i64 u0x2cd723e9fe623c7c, ; 87: lib_System.Private.Xml.Linq.dll.so => 129
	i64 u0x2ce03196fe1170d2, ; 88: Microsoft.Maui.Controls.Maps.dll => 47
	i64 u0x2d169d318a968379, ; 89: System.Threading.dll => 149
	i64 u0x2d47774b7d993f59, ; 90: sv/Microsoft.Maui.Controls.resources.dll => 26
	i64 u0x2db915caf23548d2, ; 91: System.Text.Json.dll => 145
	i64 u0x2e6f1f226821322a, ; 92: el/Microsoft.Maui.Controls.resources.dll => 5
	i64 u0x2f02f94df3200fe5, ; 93: System.Diagnostics.Process => 103
	i64 u0x2f2e98e1c89b1aff, ; 94: System.Xml.ReaderWriter => 152
	i64 u0x309ee9eeec09a71e, ; 95: lib_Xamarin.AndroidX.Fragment.dll.so => 67
	i64 u0x30bde19041cd89dd, ; 96: lib_Microsoft.Maui.Maps.dll.so => 52
	i64 u0x31195fef5d8fb552, ; 97: _Microsoft.Android.Resource.Designer.dll => 34
	i64 u0x32243413e774362a, ; 98: Xamarin.AndroidX.CardView.dll => 60
	i64 u0x3235427f8d12dae1, ; 99: lib_System.Drawing.Primitives.dll.so => 105
	i64 u0x329753a17a517811, ; 100: fr/Microsoft.Maui.Controls.resources => 8
	i64 u0x32aa989ff07a84ff, ; 101: lib_System.Xml.ReaderWriter.dll.so => 152
	i64 u0x33829542f112d59b, ; 102: System.Collections.Immutable => 93
	i64 u0x33a31443733849fe, ; 103: lib-es-Microsoft.Maui.Controls.resources.dll.so => 6
	i64 u0x341abc357fbb4ebf, ; 104: lib_System.Net.Sockets.dll.so => 122
	i64 u0x34dfd74fe2afcf37, ; 105: Microsoft.Maui => 49
	i64 u0x34e292762d9615df, ; 106: cs/Microsoft.Maui.Controls.resources.dll => 2
	i64 u0x3508234247f48404, ; 107: Microsoft.Maui.Controls => 46
	i64 u0x3549870798b4cd30, ; 108: lib_Xamarin.AndroidX.ViewPager2.dll.so => 81
	i64 u0x355282fc1c909694, ; 109: Microsoft.Extensions.Configuration => 38
	i64 u0x36b2b50fdf589ae2, ; 110: System.Reflection.Emit.Lightweight => 132
	i64 u0x374ef46b06791af6, ; 111: System.Reflection.Primitives.dll => 133
	i64 u0x380134e03b1e160a, ; 112: System.Collections.Immutable.dll => 93
	i64 u0x385c17636bb6fe6e, ; 113: Xamarin.AndroidX.CustomView.dll => 65
	i64 u0x38869c811d74050e, ; 114: System.Net.NameResolution.dll => 116
	i64 u0x393c226616977fdb, ; 115: lib_Xamarin.AndroidX.ViewPager.dll.so => 80
	i64 u0x395e37c3334cf82a, ; 116: lib-ca-Microsoft.Maui.Controls.resources.dll.so => 1
	i64 u0x39aa39fda111d9d3, ; 117: Newtonsoft.Json => 54
	i64 u0x3b860f9932505633, ; 118: lib_System.Text.Encoding.Extensions.dll.so => 143
	i64 u0x3c385377a4635511, ; 119: Mopups.dll => 53
	i64 u0x3c7c495f58ac5ee9, ; 120: Xamarin.Kotlin.StdLib => 87
	i64 u0x3d46f0b995082740, ; 121: System.Xml.Linq => 151
	i64 u0x3d9c2a242b040a50, ; 122: lib_Xamarin.AndroidX.Core.dll.so => 63
	i64 u0x407a10bb4bf95829, ; 123: lib_Xamarin.AndroidX.Navigation.Common.dll.so => 73
	i64 u0x41cab042be111c34, ; 124: lib_Xamarin.AndroidX.AppCompat.AppCompatResources.dll.so => 59
	i64 u0x43375950ec7c1b6a, ; 125: netstandard.dll => 156
	i64 u0x434c4e1d9284cdae, ; 126: Mono.Android.dll => 160
	i64 u0x43950f84de7cc79a, ; 127: pl/Microsoft.Maui.Controls.resources.dll => 20
	i64 u0x448bd33429269b19, ; 128: Microsoft.CSharp => 91
	i64 u0x4499fa3c8e494654, ; 129: lib_System.Runtime.Serialization.Primitives.dll.so => 138
	i64 u0x4515080865a951a5, ; 130: Xamarin.Kotlin.StdLib.dll => 87
	i64 u0x45c40276a42e283e, ; 131: System.Diagnostics.TraceSource => 104
	i64 u0x46a4213bc97fe5ae, ; 132: lib-ru-Microsoft.Maui.Controls.resources.dll.so => 24
	i64 u0x47358bd471172e1d, ; 133: lib_System.Xml.Linq.dll.so => 151
	i64 u0x47daf4e1afbada10, ; 134: pt/Microsoft.Maui.Controls.resources => 22
	i64 u0x4980a6419d539b0a, ; 135: lib_AsyncAwaitBestPractices.dll.so => 35
	i64 u0x49e952f19a4e2022, ; 136: System.ObjectModel => 127
	i64 u0x4a5667b2462a664b, ; 137: lib_Xamarin.AndroidX.Navigation.UI.dll.so => 76
	i64 u0x4b7b6532ded934b7, ; 138: System.Text.Json => 145
	i64 u0x4c9caee94c082049, ; 139: Xamarin.GooglePlayServices.Maps => 85
	i64 u0x4cc5f15266470798, ; 140: lib_Xamarin.AndroidX.Loader.dll.so => 72
	i64 u0x4cf6f67dc77aacd2, ; 141: System.Net.NetworkInformation.dll => 117
	i64 u0x4d3183dd245425d4, ; 142: System.Net.WebSockets.Client.dll => 124
	i64 u0x4d479f968a05e504, ; 143: System.Linq.Expressions.dll => 111
	i64 u0x4d55a010ffc4faff, ; 144: System.Private.Xml => 130
	i64 u0x4d95fccc1f67c7ca, ; 145: System.Runtime.Loader.dll => 135
	i64 u0x4dcf44c3c9b076a2, ; 146: it/Microsoft.Maui.Controls.resources.dll => 14
	i64 u0x4dd9247f1d2c3235, ; 147: Xamarin.AndroidX.Loader.dll => 72
	i64 u0x4e32f00cb0937401, ; 148: Mono.Android.Runtime => 159
	i64 u0x4ebd0c4b82c5eefc, ; 149: lib_System.Threading.Channels.dll.so => 147
	i64 u0x4f21ee6ef9eb527e, ; 150: ca/Microsoft.Maui.Controls.resources => 1
	i64 u0x5037f0be3c28c7a3, ; 151: lib_Microsoft.Maui.Controls.dll.so => 46
	i64 u0x5131bbe80989093f, ; 152: Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll => 70
	i64 u0x51bb8a2afe774e32, ; 153: System.Drawing => 106
	i64 u0x526ce79eb8e90527, ; 154: lib_System.Net.Primitives.dll.so => 118
	i64 u0x52829f00b4467c38, ; 155: lib_System.Data.Common.dll.so => 101
	i64 u0x529ffe06f39ab8db, ; 156: Xamarin.AndroidX.Core => 63
	i64 u0x52ff996554dbf352, ; 157: Microsoft.Maui.Graphics => 51
	i64 u0x535f7e40e8fef8af, ; 158: lib-sk-Microsoft.Maui.Controls.resources.dll.so => 25
	i64 u0x53a96d5c86c9e194, ; 159: System.Net.NetworkInformation => 117
	i64 u0x53c3014b9437e684, ; 160: lib-zh-HK-Microsoft.Maui.Controls.resources.dll.so => 31
	i64 u0x5435e6f049e9bc37, ; 161: System.Security.Claims.dll => 140
	i64 u0x54795225dd1587af, ; 162: lib_System.Runtime.dll.so => 139
	i64 u0x556e8b63b660ab8b, ; 163: Xamarin.AndroidX.Lifecycle.Common.Jvm.dll => 68
	i64 u0x5588627c9a108ec9, ; 164: System.Collections.Specialized => 95
	i64 u0x571c5cfbec5ae8e2, ; 165: System.Private.Uri => 128
	i64 u0x579a06fed6eec900, ; 166: System.Private.CoreLib.dll => 157
	i64 u0x57c542c14049b66d, ; 167: System.Diagnostics.DiagnosticSource => 102
	i64 u0x58601b2dda4a27b9, ; 168: lib-ja-Microsoft.Maui.Controls.resources.dll.so => 15
	i64 u0x58688d9af496b168, ; 169: Microsoft.Extensions.DependencyInjection.dll => 40
	i64 u0x595a356d23e8da9a, ; 170: lib_Microsoft.CSharp.dll.so => 91
	i64 u0x5a89a886ae30258d, ; 171: lib_Xamarin.AndroidX.CoordinatorLayout.dll.so => 62
	i64 u0x5a8f6699f4a1caa9, ; 172: lib_System.Threading.dll.so => 149
	i64 u0x5ae9cd33b15841bf, ; 173: System.ComponentModel => 99
	i64 u0x5b5f0e240a06a2a2, ; 174: da/Microsoft.Maui.Controls.resources.dll => 3
	i64 u0x5b755276902c8414, ; 175: Xamarin.GooglePlayServices.Base => 83
	i64 u0x5c393624b8176517, ; 176: lib_Microsoft.Extensions.Logging.dll.so => 42
	i64 u0x5d0a4a29b02d9d3c, ; 177: System.Net.WebHeaderCollection.dll => 123
	i64 u0x5db0cbbd1028510e, ; 178: lib_System.Runtime.InteropServices.dll.so => 134
	i64 u0x5db30905d3e5013b, ; 179: Xamarin.AndroidX.Collection.Jvm.dll => 61
	i64 u0x5e467bc8f09ad026, ; 180: System.Collections.Specialized.dll => 95
	i64 u0x5ea92fdb19ec8c4c, ; 181: System.Text.Encodings.Web.dll => 144
	i64 u0x5eb8046dd40e9ac3, ; 182: System.ComponentModel.Primitives => 97
	i64 u0x5eee1376d94c7f5e, ; 183: System.Net.HttpListener.dll => 115
	i64 u0x5f36ccf5c6a57e24, ; 184: System.Xml.ReaderWriter.dll => 152
	i64 u0x5f4294b9b63cb842, ; 185: System.Data.Common => 101
	i64 u0x5f9a2d823f664957, ; 186: lib-el-Microsoft.Maui.Controls.resources.dll.so => 5
	i64 u0x609f4b7b63d802d4, ; 187: lib_Microsoft.Extensions.DependencyInjection.dll.so => 40
	i64 u0x60cd4e33d7e60134, ; 188: Xamarin.KotlinX.Coroutines.Core.Jvm => 88
	i64 u0x60f62d786afcf130, ; 189: System.Memory => 113
	i64 u0x61be8d1299194243, ; 190: Microsoft.Maui.Controls.Xaml => 48
	i64 u0x61d2cba29557038f, ; 191: de/Microsoft.Maui.Controls.resources => 4
	i64 u0x61d88f399afb2f45, ; 192: lib_System.Runtime.Loader.dll.so => 135
	i64 u0x622eef6f9e59068d, ; 193: System.Private.CoreLib => 157
	i64 u0x62ecc683af4df22b, ; 194: StreetLightApp => 90
	i64 u0x63f1f6883c1e23c2, ; 195: lib_System.Collections.Immutable.dll.so => 93
	i64 u0x6400f68068c1e9f1, ; 196: Xamarin.Google.Android.Material.dll => 82
	i64 u0x658f524e4aba7dad, ; 197: CommunityToolkit.Maui.dll => 36
	i64 u0x65ecac39144dd3cc, ; 198: Microsoft.Maui.Controls.dll => 46
	i64 u0x65ece51227bfa724, ; 199: lib_System.Runtime.Numerics.dll.so => 136
	i64 u0x666e27ef6dad9ee1, ; 200: RestSharp => 55
	i64 u0x6692e924eade1b29, ; 201: lib_System.Console.dll.so => 100
	i64 u0x66a4e5c6a3fb0bae, ; 202: lib_Xamarin.AndroidX.Lifecycle.ViewModel.Android.dll.so => 70
	i64 u0x66d13304ce1a3efa, ; 203: Xamarin.AndroidX.CursorAdapter => 64
	i64 u0x68558ec653afa616, ; 204: lib-da-Microsoft.Maui.Controls.resources.dll.so => 3
	i64 u0x6872ec7a2e36b1ac, ; 205: System.Drawing.Primitives.dll => 105
	i64 u0x68fbbbe2eb455198, ; 206: System.Formats.Asn1 => 107
	i64 u0x69063fc0ba8e6bdd, ; 207: he/Microsoft.Maui.Controls.resources.dll => 9
	i64 u0x69fbb0da5a16621d, ; 208: RestSharp.dll => 55
	i64 u0x6a4d7577b2317255, ; 209: System.Runtime.InteropServices.dll => 134
	i64 u0x6ace3b74b15ee4a4, ; 210: nb/Microsoft.Maui.Controls.resources => 18
	i64 u0x6d12bfaa99c72b1f, ; 211: lib_Microsoft.Maui.Graphics.dll.so => 51
	i64 u0x6d79993361e10ef2, ; 212: Microsoft.Extensions.Primitives => 45
	i64 u0x6d86d56b84c8eb71, ; 213: lib_Xamarin.AndroidX.CursorAdapter.dll.so => 64
	i64 u0x6d9bea6b3e895cf7, ; 214: Microsoft.Extensions.Primitives.dll => 45
	i64 u0x6e25a02c3833319a, ; 215: lib_Xamarin.AndroidX.Navigation.Fragment.dll.so => 74
	i64 u0x6fd2265da78b93a4, ; 216: lib_Microsoft.Maui.dll.so => 49
	i64 u0x6fdfc7de82c33008, ; 217: cs/Microsoft.Maui.Controls.resources => 2
	i64 u0x70e99f48c05cb921, ; 218: tr/Microsoft.Maui.Controls.resources.dll => 28
	i64 u0x70fd3deda22442d2, ; 219: lib-nb-Microsoft.Maui.Controls.resources.dll.so => 18
	i64 u0x71a495ea3761dde8, ; 220: lib-it-Microsoft.Maui.Controls.resources.dll.so => 14
	i64 u0x71ad672adbe48f35, ; 221: System.ComponentModel.Primitives.dll => 97
	i64 u0x72b1fb4109e08d7b, ; 222: lib-hr-Microsoft.Maui.Controls.resources.dll.so => 11
	i64 u0x73e4ce94e2eb6ffc, ; 223: lib_System.Memory.dll.so => 113
	i64 u0x755a91767330b3d4, ; 224: lib_Microsoft.Extensions.Configuration.dll.so => 38
	i64 u0x75f5d8ba43e33e01, ; 225: Mopups => 53
	i64 u0x76012e7334db86e5, ; 226: lib_Xamarin.AndroidX.SavedState.dll.so => 78
	i64 u0x76ca07b878f44da0, ; 227: System.Runtime.Numerics.dll => 136
	i64 u0x780bc73597a503a9, ; 228: lib-ms-Microsoft.Maui.Controls.resources.dll.so => 17
	i64 u0x783606d1e53e7a1a, ; 229: th/Microsoft.Maui.Controls.resources.dll => 27
	i64 u0x78a45e51311409b6, ; 230: Xamarin.AndroidX.Fragment.dll => 67
	i64 u0x7adb8da2ac89b647, ; 231: fi/Microsoft.Maui.Controls.resources.dll => 7
	i64 u0x7bef86a4335c4870, ; 232: System.ComponentModel.TypeConverter => 98
	i64 u0x7c0820144cd34d6a, ; 233: sk/Microsoft.Maui.Controls.resources.dll => 25
	i64 u0x7c2a0bd1e0f988fc, ; 234: lib-de-Microsoft.Maui.Controls.resources.dll.so => 4
	i64 u0x7cb95ad2a929d044, ; 235: Xamarin.GooglePlayServices.Basement => 84
	i64 u0x7cc637f941f716d0, ; 236: CommunityToolkit.Maui.Core => 37
	i64 u0x7d649b75d580bb42, ; 237: ms/Microsoft.Maui.Controls.resources.dll => 17
	i64 u0x7d8ee2bdc8e3aad1, ; 238: System.Numerics.Vectors => 126
	i64 u0x7dfc3d6d9d8d7b70, ; 239: System.Collections => 96
	i64 u0x7e302e110e1e1346, ; 240: lib_System.Security.Claims.dll.so => 140
	i64 u0x7e946809d6008ef2, ; 241: lib_System.ObjectModel.dll.so => 127
	i64 u0x7eb4f0dc47488736, ; 242: lib_Xamarin.GooglePlayServices.Tasks.dll.so => 86
	i64 u0x7ecc13347c8fd849, ; 243: lib_System.ComponentModel.dll.so => 99
	i64 u0x7f00ddd9b9ca5a13, ; 244: Xamarin.AndroidX.ViewPager.dll => 80
	i64 u0x7f9351cd44b1273f, ; 245: Microsoft.Extensions.Configuration.Abstractions => 39
	i64 u0x7fbd557c99b3ce6f, ; 246: lib_Xamarin.AndroidX.Lifecycle.LiveData.Core.dll.so => 69
	i64 u0x812c069d5cdecc17, ; 247: System.dll => 155
	i64 u0x81ab745f6c0f5ce6, ; 248: zh-Hant/Microsoft.Maui.Controls.resources => 33
	i64 u0x8277f2be6b5ce05f, ; 249: Xamarin.AndroidX.AppCompat => 58
	i64 u0x828f06563b30bc50, ; 250: lib_Xamarin.AndroidX.CardView.dll.so => 60
	i64 u0x82df8f5532a10c59, ; 251: lib_System.Drawing.dll.so => 106
	i64 u0x82f6403342e12049, ; 252: uk/Microsoft.Maui.Controls.resources => 29
	i64 u0x83c14ba66c8e2b8c, ; 253: zh-Hans/Microsoft.Maui.Controls.resources => 32
	i64 u0x86a909228dc7657b, ; 254: lib-zh-Hant-Microsoft.Maui.Controls.resources.dll.so => 33
	i64 u0x86b3e00c36b84509, ; 255: Microsoft.Extensions.Configuration.dll => 38
	i64 u0x87c69b87d9283884, ; 256: lib_System.Threading.Thread.dll.so => 148
	i64 u0x87f6569b25707834, ; 257: System.IO.Compression.Brotli.dll => 108
	i64 u0x8842b3a5d2d3fb36, ; 258: Microsoft.Maui.Essentials => 50
	i64 u0x88bda98e0cffb7a9, ; 259: lib_Xamarin.KotlinX.Coroutines.Core.Jvm.dll.so => 88
	i64 u0x8930322c7bd8f768, ; 260: netstandard => 156
	i64 u0x897a606c9e39c75f, ; 261: lib_System.ComponentModel.Primitives.dll.so => 97
	i64 u0x8ad229ea26432ee2, ; 262: Xamarin.AndroidX.Loader => 72
	i64 u0x8b4ff5d0fdd5faa1, ; 263: lib_System.Diagnostics.DiagnosticSource.dll.so => 102
	i64 u0x8b541d476eb3774c, ; 264: System.Security.Principal.Windows => 142
	i64 u0x8b8d01333a96d0b5, ; 265: System.Diagnostics.Process.dll => 103
	i64 u0x8b9ceca7acae3451, ; 266: lib-he-Microsoft.Maui.Controls.resources.dll.so => 9
	i64 u0x8ca24177b75ede73, ; 267: WatsonWebsocket.dll => 56
	i64 u0x8cdfdb4ce85fb925, ; 268: lib_System.Security.Principal.Windows.dll.so => 142
	i64 u0x8d0f420977c2c1c7, ; 269: Xamarin.AndroidX.CursorAdapter.dll => 64
	i64 u0x8d7b8ab4b3310ead, ; 270: System.Threading => 149
	i64 u0x8da188285aadfe8e, ; 271: System.Collections.Concurrent => 92
	i64 u0x8ec6e06a61c1baeb, ; 272: lib_Newtonsoft.Json.dll.so => 54
	i64 u0x8ed807bfe9858dfc, ; 273: Xamarin.AndroidX.Navigation.Common => 73
	i64 u0x8ee08b8194a30f48, ; 274: lib-hi-Microsoft.Maui.Controls.resources.dll.so => 10
	i64 u0x8ef7601039857a44, ; 275: lib-ro-Microsoft.Maui.Controls.resources.dll.so => 23
	i64 u0x8efbc0801a122264, ; 276: Xamarin.GooglePlayServices.Tasks.dll => 86
	i64 u0x8f32c6f611f6ffab, ; 277: pt/Microsoft.Maui.Controls.resources.dll => 22
	i64 u0x8f8829d21c8985a4, ; 278: lib-pt-BR-Microsoft.Maui.Controls.resources.dll.so => 21
	i64 u0x90263f8448b8f572, ; 279: lib_System.Diagnostics.TraceSource.dll.so => 104
	i64 u0x903101b46fb73a04, ; 280: _Microsoft.Android.Resource.Designer => 34
	i64 u0x90393bd4865292f3, ; 281: lib_System.IO.Compression.dll.so => 109
	i64 u0x90634f86c5ebe2b5, ; 282: Xamarin.AndroidX.Lifecycle.ViewModel.Android => 70
	i64 u0x907b636704ad79ef, ; 283: lib_Microsoft.Maui.Controls.Xaml.dll.so => 48
	i64 u0x91418dc638b29e68, ; 284: lib_Xamarin.AndroidX.CustomView.dll.so => 65
	i64 u0x9157bd523cd7ed36, ; 285: lib_System.Text.Json.dll.so => 145
	i64 u0x91a74f07b30d37e2, ; 286: System.Linq.dll => 112
	i64 u0x91fa41a87223399f, ; 287: ca/Microsoft.Maui.Controls.resources.dll => 1
	i64 u0x93cfa73ab28d6e35, ; 288: ms/Microsoft.Maui.Controls.resources => 17
	i64 u0x944077d8ca3c6580, ; 289: System.IO.Compression.dll => 109
	i64 u0x967fc325e09bfa8c, ; 290: es/Microsoft.Maui.Controls.resources => 6
	i64 u0x9732d8dbddea3d9a, ; 291: id/Microsoft.Maui.Controls.resources => 13
	i64 u0x978be80e5210d31b, ; 292: Microsoft.Maui.Graphics.dll => 51
	i64 u0x979ab54025cc1c7f, ; 293: lib_Xamarin.GooglePlayServices.Base.dll.so => 83
	i64 u0x97b8c771ea3e4220, ; 294: System.ComponentModel.dll => 99
	i64 u0x97e144c9d3c6976e, ; 295: System.Collections.Concurrent.dll => 92
	i64 u0x991d510397f92d9d, ; 296: System.Linq.Expressions => 111
	i64 u0x99a00ca5270c6878, ; 297: Xamarin.AndroidX.Navigation.Runtime => 75
	i64 u0x99cdc6d1f2d3a72f, ; 298: ko/Microsoft.Maui.Controls.resources.dll => 16
	i64 u0x9d185d226bf3df50, ; 299: lib_RestSharp.dll.so => 55
	i64 u0x9d5dbcf5a48583fe, ; 300: lib_Xamarin.AndroidX.Activity.dll.so => 57
	i64 u0x9d74dee1a7725f34, ; 301: Microsoft.Extensions.Configuration.Abstractions.dll => 39
	i64 u0x9e4534b6adaf6e84, ; 302: nl/Microsoft.Maui.Controls.resources => 19
	i64 u0x9eaf1efdf6f7267e, ; 303: Xamarin.AndroidX.Navigation.Common.dll => 73
	i64 u0x9ef542cf1f78c506, ; 304: Xamarin.AndroidX.Lifecycle.LiveData.Core => 69
	i64 u0xa0d8259f4cc284ec, ; 305: lib_System.Security.Cryptography.dll.so => 141
	i64 u0xa1440773ee9d341e, ; 306: Xamarin.Google.Android.Material => 82
	i64 u0xa1b9d7c27f47219f, ; 307: Xamarin.AndroidX.Navigation.UI.dll => 76
	i64 u0xa2572680829d2c7c, ; 308: System.IO.Pipelines.dll => 110
	i64 u0xa46aa1eaa214539b, ; 309: ko/Microsoft.Maui.Controls.resources => 16
	i64 u0xa4edc8f2ceae241a, ; 310: System.Data.Common.dll => 101
	i64 u0xa5494f40f128ce6a, ; 311: System.Runtime.Serialization.Formatters.dll => 137
	i64 u0xa5e599d1e0524750, ; 312: System.Numerics.Vectors.dll => 126
	i64 u0xa5f1ba49b85dd355, ; 313: System.Security.Cryptography.dll => 141
	i64 u0xa61975a5a37873ea, ; 314: lib_System.Xml.XmlSerializer.dll.so => 154
	i64 u0xa67dbee13e1df9ca, ; 315: Xamarin.AndroidX.SavedState.dll => 78
	i64 u0xa68a420042bb9b1f, ; 316: Xamarin.AndroidX.DrawerLayout.dll => 66
	i64 u0xa78ce3745383236a, ; 317: Xamarin.AndroidX.Lifecycle.Common.Jvm => 68
	i64 u0xa7c31b56b4dc7b33, ; 318: hu/Microsoft.Maui.Controls.resources => 12
	i64 u0xa843f6095f0d247d, ; 319: Xamarin.GooglePlayServices.Base.dll => 83
	i64 u0xa964304b5631e28a, ; 320: CommunityToolkit.Maui.Core.dll => 37
	i64 u0xaa2219c8e3449ff5, ; 321: Microsoft.Extensions.Logging.Abstractions => 43
	i64 u0xaa443ac34067eeef, ; 322: System.Private.Xml.dll => 130
	i64 u0xaa52de307ef5d1dd, ; 323: System.Net.Http => 114
	i64 u0xaaaf86367285a918, ; 324: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 41
	i64 u0xaaf84bb3f052a265, ; 325: el/Microsoft.Maui.Controls.resources => 5
	i64 u0xab61dc30d4483813, ; 326: AsyncAwaitBestPractices => 35
	i64 u0xab9c1b2687d86b0b, ; 327: lib_System.Linq.Expressions.dll.so => 111
	i64 u0xac2af3fa195a15ce, ; 328: System.Runtime.Numerics => 136
	i64 u0xac5376a2a538dc10, ; 329: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 69
	i64 u0xac79c7e46047ad98, ; 330: System.Security.Principal.Windows.dll => 142
	i64 u0xac98d31068e24591, ; 331: System.Xml.XDocument => 153
	i64 u0xacadd3cbe26c6a9b, ; 332: lib_StreetLightApp.dll.so => 90
	i64 u0xacd46e002c3ccb97, ; 333: ro/Microsoft.Maui.Controls.resources => 23
	i64 u0xacf42eea7ef9cd12, ; 334: System.Threading.Channels => 147
	i64 u0xad89c07347f1bad6, ; 335: nl/Microsoft.Maui.Controls.resources.dll => 19
	i64 u0xadbb53caf78a79d2, ; 336: System.Web.HttpUtility => 150
	i64 u0xadc90ab061a9e6e4, ; 337: System.ComponentModel.TypeConverter.dll => 98
	i64 u0xadf4cf30debbeb9a, ; 338: System.Net.ServicePoint.dll => 121
	i64 u0xadf511667bef3595, ; 339: System.Net.Security => 120
	i64 u0xae282bcd03739de7, ; 340: Java.Interop => 158
	i64 u0xae53579c90db1107, ; 341: System.ObjectModel.dll => 127
	i64 u0xafe29f45095518e7, ; 342: lib_Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll.so => 71
	i64 u0xb05cc42cd94c6d9d, ; 343: lib-sv-Microsoft.Maui.Controls.resources.dll.so => 26
	i64 u0xb220631954820169, ; 344: System.Text.RegularExpressions => 146
	i64 u0xb2a3f67f3bf29fce, ; 345: da/Microsoft.Maui.Controls.resources => 3
	i64 u0xb3f0a0fcda8d3ebc, ; 346: Xamarin.AndroidX.CardView => 60
	i64 u0xb46be1aa6d4fff93, ; 347: hi/Microsoft.Maui.Controls.resources => 10
	i64 u0xb477491be13109d8, ; 348: ar/Microsoft.Maui.Controls.resources => 0
	i64 u0xb4bd7015ecee9d86, ; 349: System.IO.Pipelines => 110
	i64 u0xb5c7fcdafbc67ee4, ; 350: Microsoft.Extensions.Logging.Abstractions.dll => 43
	i64 u0xb7212c4683a94afe, ; 351: System.Drawing.Primitives => 105
	i64 u0xb7b7753d1f319409, ; 352: sv/Microsoft.Maui.Controls.resources => 26
	i64 u0xb81a2c6e0aee50fe, ; 353: lib_System.Private.CoreLib.dll.so => 157
	i64 u0xb8c60af47c08d4da, ; 354: System.Net.ServicePoint => 121
	i64 u0xb9185c33a1643eed, ; 355: Microsoft.CSharp.dll => 91
	i64 u0xb9b19a3eb1924681, ; 356: lib_Microsoft.Maui.Controls.Maps.dll.so => 47
	i64 u0xb9f64d3b230def68, ; 357: lib-pt-Microsoft.Maui.Controls.resources.dll.so => 22
	i64 u0xb9fc3c8a556e3691, ; 358: ja/Microsoft.Maui.Controls.resources => 15
	i64 u0xba4670aa94a2b3c6, ; 359: lib_System.Xml.XDocument.dll.so => 153
	i64 u0xba48785529705af9, ; 360: System.Collections.dll => 96
	i64 u0xbb65706fde942ce3, ; 361: System.Net.Sockets => 122
	i64 u0xbb90881f448f3119, ; 362: lib_WatsonWebsocket.dll.so => 56
	i64 u0xbbd180354b67271a, ; 363: System.Runtime.Serialization.Formatters => 137
	i64 u0xbd0e2c0d55246576, ; 364: System.Net.Http.dll => 114
	i64 u0xbd3fbd85b9e1cb29, ; 365: lib_System.Net.HttpListener.dll.so => 115
	i64 u0xbd437a2cdb333d0d, ; 366: Xamarin.AndroidX.ViewPager2 => 81
	i64 u0xbee38d4a88835966, ; 367: Xamarin.AndroidX.AppCompat.AppCompatResources => 59
	i64 u0xc040a4ab55817f58, ; 368: ar/Microsoft.Maui.Controls.resources.dll => 0
	i64 u0xc0d928351ab5ca77, ; 369: System.Console.dll => 100
	i64 u0xc12b8b3afa48329c, ; 370: lib_System.Linq.dll.so => 112
	i64 u0xc1ff9ae3cdb6e1e6, ; 371: Xamarin.AndroidX.Activity.dll => 57
	i64 u0xc28c50f32f81cc73, ; 372: ja/Microsoft.Maui.Controls.resources.dll => 15
	i64 u0xc2bcfec99f69365e, ; 373: Xamarin.AndroidX.ViewPager2.dll => 81
	i64 u0xc421b61fd853169d, ; 374: lib_System.Net.WebSockets.Client.dll.so => 124
	i64 u0xc4d3858ed4d08512, ; 375: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 71
	i64 u0xc50fded0ded1418c, ; 376: lib_System.ComponentModel.TypeConverter.dll.so => 98
	i64 u0xc519125d6bc8fb11, ; 377: lib_System.Net.Requests.dll.so => 119
	i64 u0xc5293b19e4dc230e, ; 378: Xamarin.AndroidX.Navigation.Fragment => 74
	i64 u0xc5325b2fcb37446f, ; 379: lib_System.Private.Xml.dll.so => 130
	i64 u0xc5a0f4b95a699af7, ; 380: lib_System.Private.Uri.dll.so => 128
	i64 u0xc64f6952cef5d09f, ; 381: Microsoft.Maui.Maps.dll => 52
	i64 u0xc68e480c8069e1f7, ; 382: Microsoft.Maui.Maps => 52
	i64 u0xc7c01e7d7c93a110, ; 383: System.Text.Encoding.Extensions.dll => 143
	i64 u0xc7ce851898a4548e, ; 384: lib_System.Web.HttpUtility.dll.so => 150
	i64 u0xc7ed073e3cbec16d, ; 385: WatsonWebsocket => 56
	i64 u0xc858a28d9ee5a6c5, ; 386: lib_System.Collections.Specialized.dll.so => 95
	i64 u0xc9e54b32fc19baf3, ; 387: lib_CommunityToolkit.Maui.dll.so => 36
	i64 u0xca3a723e7342c5b6, ; 388: lib-tr-Microsoft.Maui.Controls.resources.dll.so => 28
	i64 u0xcab3493c70141c2d, ; 389: pl/Microsoft.Maui.Controls.resources => 20
	i64 u0xcacfddc9f7c6de76, ; 390: ro/Microsoft.Maui.Controls.resources.dll => 23
	i64 u0xcbd4fdd9cef4a294, ; 391: lib__Microsoft.Android.Resource.Designer.dll.so => 34
	i64 u0xcc2876b32ef2794c, ; 392: lib_System.Text.RegularExpressions.dll.so => 146
	i64 u0xcc5c3bb714c4561e, ; 393: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 88
	i64 u0xcc76886e09b88260, ; 394: Xamarin.KotlinX.Serialization.Core.Jvm.dll => 89
	i64 u0xccf25c4b634ccd3a, ; 395: zh-Hans/Microsoft.Maui.Controls.resources.dll => 32
	i64 u0xcd10a42808629144, ; 396: System.Net.Requests => 119
	i64 u0xcdd0c48b6937b21c, ; 397: Xamarin.AndroidX.SwipeRefreshLayout => 79
	i64 u0xcf23d8093f3ceadf, ; 398: System.Diagnostics.DiagnosticSource.dll => 102
	i64 u0xcf8fc898f98b0d34, ; 399: System.Private.Xml.Linq => 129
	i64 u0xcfb21487d9cb358b, ; 400: Xamarin.GooglePlayServices.Maps.dll => 85
	i64 u0xd1194e1d8a8de83c, ; 401: lib_Xamarin.AndroidX.Lifecycle.Common.Jvm.dll.so => 68
	i64 u0xd333d0af9e423810, ; 402: System.Runtime.InteropServices => 134
	i64 u0xd3426d966bb704f5, ; 403: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 59
	i64 u0xd3651b6fc3125825, ; 404: System.Private.Uri.dll => 128
	i64 u0xd373685349b1fe8b, ; 405: Microsoft.Extensions.Logging.dll => 42
	i64 u0xd3e4c8d6a2d5d470, ; 406: it/Microsoft.Maui.Controls.resources => 14
	i64 u0xd4645626dffec99d, ; 407: lib_Microsoft.Extensions.DependencyInjection.Abstractions.dll.so => 41
	i64 u0xd5507e11a2b2839f, ; 408: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 71
	i64 u0xd6694f8359737e4e, ; 409: Xamarin.AndroidX.SavedState => 78
	i64 u0xd6d21782156bc35b, ; 410: Xamarin.AndroidX.SwipeRefreshLayout.dll => 79
	i64 u0xd72329819cbbbc44, ; 411: lib_Microsoft.Extensions.Configuration.Abstractions.dll.so => 39
	i64 u0xd72c760af136e863, ; 412: System.Xml.XmlSerializer.dll => 154
	i64 u0xd7b3764ada9d341d, ; 413: lib_Microsoft.Extensions.Logging.Abstractions.dll.so => 43
	i64 u0xda1dfa4c534a9251, ; 414: Microsoft.Extensions.DependencyInjection => 40
	i64 u0xdad05a11827959a3, ; 415: System.Collections.NonGeneric.dll => 94
	i64 u0xdb5383ab5865c007, ; 416: lib-vi-Microsoft.Maui.Controls.resources.dll.so => 30
	i64 u0xdb58816721c02a59, ; 417: lib_System.Reflection.Emit.ILGeneration.dll.so => 131
	i64 u0xdbeda89f832aa805, ; 418: vi/Microsoft.Maui.Controls.resources.dll => 30
	i64 u0xdbf9607a441b4505, ; 419: System.Linq => 112
	i64 u0xdce2c53525640bf3, ; 420: Microsoft.Extensions.Logging => 42
	i64 u0xdd2b722d78ef5f43, ; 421: System.Runtime.dll => 139
	i64 u0xdd67031857c72f96, ; 422: lib_System.Text.Encodings.Web.dll.so => 144
	i64 u0xdde30e6b77aa6f6c, ; 423: lib-zh-Hans-Microsoft.Maui.Controls.resources.dll.so => 32
	i64 u0xde110ae80fa7c2e2, ; 424: System.Xml.XDocument.dll => 153
	i64 u0xde8769ebda7d8647, ; 425: hr/Microsoft.Maui.Controls.resources.dll => 11
	i64 u0xe0142572c095a480, ; 426: Xamarin.AndroidX.AppCompat.dll => 58
	i64 u0xe02f89350ec78051, ; 427: Xamarin.AndroidX.CoordinatorLayout.dll => 62
	i64 u0xe192a588d4410686, ; 428: lib_System.IO.Pipelines.dll.so => 110
	i64 u0xe1a08bd3fa539e0d, ; 429: System.Runtime.Loader => 135
	i64 u0xe1b52f9f816c70ef, ; 430: System.Private.Xml.Linq.dll => 129
	i64 u0xe1ecfdb7fff86067, ; 431: System.Net.Security.dll => 120
	i64 u0xe2420585aeceb728, ; 432: System.Net.Requests.dll => 119
	i64 u0xe29b73bc11392966, ; 433: lib-id-Microsoft.Maui.Controls.resources.dll.so => 13
	i64 u0xe3811d68d4fe8463, ; 434: pt-BR/Microsoft.Maui.Controls.resources.dll => 21
	i64 u0xe494f7ced4ecd10a, ; 435: hu/Microsoft.Maui.Controls.resources.dll => 12
	i64 u0xe4a9b1e40d1e8917, ; 436: lib-fi-Microsoft.Maui.Controls.resources.dll.so => 7
	i64 u0xe4f74a0b5bf9703f, ; 437: System.Runtime.Serialization.Primitives => 138
	i64 u0xe5434e8a119ceb69, ; 438: lib_Mono.Android.dll.so => 160
	i64 u0xe89a2a9ef110899b, ; 439: System.Drawing.dll => 106
	i64 u0xedc4817167106c23, ; 440: System.Net.Sockets.dll => 122
	i64 u0xedc632067fb20ff3, ; 441: System.Memory.dll => 113
	i64 u0xedc8e4ca71a02a8b, ; 442: Xamarin.AndroidX.Navigation.Runtime.dll => 75
	i64 u0xee27c952ed6d058b, ; 443: Microsoft.Maui.Controls.Maps => 47
	i64 u0xeeb7ebb80150501b, ; 444: lib_Xamarin.AndroidX.Collection.Jvm.dll.so => 61
	i64 u0xef72742e1bcca27a, ; 445: Microsoft.Maui.Essentials.dll => 50
	i64 u0xefec0b7fdc57ec42, ; 446: Xamarin.AndroidX.Activity => 57
	i64 u0xf00c29406ea45e19, ; 447: es/Microsoft.Maui.Controls.resources.dll => 6
	i64 u0xf09e47b6ae914f6e, ; 448: System.Net.NameResolution => 116
	i64 u0xf0bb49dadd3a1fe1, ; 449: lib_System.Net.ServicePoint.dll.so => 121
	i64 u0xf0de2537ee19c6ca, ; 450: lib_System.Net.WebHeaderCollection.dll.so => 123
	i64 u0xf11b621fc87b983f, ; 451: Microsoft.Maui.Controls.Xaml.dll => 48
	i64 u0xf1c4b4005493d871, ; 452: System.Formats.Asn1.dll => 107
	i64 u0xf238bd79489d3a96, ; 453: lib-nl-Microsoft.Maui.Controls.resources.dll.so => 19
	i64 u0xf37221fda4ef8830, ; 454: lib_Xamarin.Google.Android.Material.dll.so => 82
	i64 u0xf3ddfe05336abf29, ; 455: System => 155
	i64 u0xf408654b2a135055, ; 456: System.Reflection.Emit.ILGeneration.dll => 131
	i64 u0xf4c1dd70a5496a17, ; 457: System.IO.Compression => 109
	i64 u0xf5fc7602fe27b333, ; 458: System.Net.WebHeaderCollection => 123
	i64 u0xf6077741019d7428, ; 459: Xamarin.AndroidX.CoordinatorLayout => 62
	i64 u0xf77b20923f07c667, ; 460: de/Microsoft.Maui.Controls.resources.dll => 4
	i64 u0xf7e2cac4c45067b3, ; 461: lib_System.Numerics.Vectors.dll.so => 126
	i64 u0xf7e74930e0e3d214, ; 462: zh-HK/Microsoft.Maui.Controls.resources.dll => 31
	i64 u0xf7fa0bf77fe677cc, ; 463: Newtonsoft.Json.dll => 54
	i64 u0xf84773b5c81e3cef, ; 464: lib-uk-Microsoft.Maui.Controls.resources.dll.so => 29
	i64 u0xf8b77539b362d3ba, ; 465: lib_System.Reflection.Primitives.dll.so => 133
	i64 u0xf8e045dc345b2ea3, ; 466: lib_Xamarin.AndroidX.RecyclerView.dll.so => 77
	i64 u0xf915dc29808193a1, ; 467: System.Web.HttpUtility.dll => 150
	i64 u0xf96c777a2a0686f4, ; 468: hi/Microsoft.Maui.Controls.resources.dll => 10
	i64 u0xf9eec5bb3a6aedc6, ; 469: Microsoft.Extensions.Options => 44
	i64 u0xfa3f278f288b0e84, ; 470: lib_System.Net.Security.dll.so => 120
	i64 u0xfa5ed7226d978949, ; 471: lib-ar-Microsoft.Maui.Controls.resources.dll.so => 0
	i64 u0xfa645d91e9fc4cba, ; 472: System.Threading.Thread => 148
	i64 u0xfb2eb63cfdeda9a5, ; 473: StreetLightApp.dll => 90
	i64 u0xfbf0a31c9fc34bc4, ; 474: lib_System.Net.Http.dll.so => 114
	i64 u0xfc6b7527cc280b3f, ; 475: lib_System.Runtime.Serialization.Formatters.dll.so => 137
	i64 u0xfc719aec26adf9d9, ; 476: Xamarin.AndroidX.Navigation.Fragment.dll => 74
	i64 u0xfd22f00870e40ae0, ; 477: lib_Xamarin.AndroidX.DrawerLayout.dll.so => 66
	i64 u0xfd536c702f64dc47, ; 478: System.Text.Encoding.Extensions => 143
	i64 u0xfd583f7657b6a1cb, ; 479: Xamarin.AndroidX.Fragment => 67
	i64 u0xfda36abccf05cf5c, ; 480: System.Net.WebSockets.Client => 124
	i64 u0xfdbe4710aa9beeff, ; 481: CommunityToolkit.Maui => 36
	i64 u0xfeae9952cf03b8cb ; 482: tr/Microsoft.Maui.Controls.resources => 28
], align 16

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [483 x i32] [
	i32 79, i32 35, i32 75, i32 37, i32 159, i32 58, i32 24, i32 2,
	i32 30, i32 118, i32 86, i32 77, i32 96, i32 49, i32 31, i32 151,
	i32 61, i32 24, i32 94, i32 133, i32 66, i32 44, i32 94, i32 84,
	i32 141, i32 147, i32 25, i32 89, i32 80, i32 21, i32 85, i32 160,
	i32 50, i32 116, i32 115, i32 65, i32 108, i32 125, i32 132, i32 77,
	i32 8, i32 158, i32 9, i32 41, i32 125, i32 156, i32 12, i32 144,
	i32 89, i32 18, i32 140, i32 92, i32 155, i32 27, i32 159, i32 76,
	i32 16, i32 44, i32 154, i32 108, i32 103, i32 139, i32 131, i32 27,
	i32 84, i32 148, i32 100, i32 63, i32 138, i32 8, i32 87, i32 45,
	i32 13, i32 11, i32 125, i32 158, i32 118, i32 29, i32 117, i32 53,
	i32 104, i32 7, i32 146, i32 107, i32 33, i32 20, i32 132, i32 129,
	i32 47, i32 149, i32 26, i32 145, i32 5, i32 103, i32 152, i32 67,
	i32 52, i32 34, i32 60, i32 105, i32 8, i32 152, i32 93, i32 6,
	i32 122, i32 49, i32 2, i32 46, i32 81, i32 38, i32 132, i32 133,
	i32 93, i32 65, i32 116, i32 80, i32 1, i32 54, i32 143, i32 53,
	i32 87, i32 151, i32 63, i32 73, i32 59, i32 156, i32 160, i32 20,
	i32 91, i32 138, i32 87, i32 104, i32 24, i32 151, i32 22, i32 35,
	i32 127, i32 76, i32 145, i32 85, i32 72, i32 117, i32 124, i32 111,
	i32 130, i32 135, i32 14, i32 72, i32 159, i32 147, i32 1, i32 46,
	i32 70, i32 106, i32 118, i32 101, i32 63, i32 51, i32 25, i32 117,
	i32 31, i32 140, i32 139, i32 68, i32 95, i32 128, i32 157, i32 102,
	i32 15, i32 40, i32 91, i32 62, i32 149, i32 99, i32 3, i32 83,
	i32 42, i32 123, i32 134, i32 61, i32 95, i32 144, i32 97, i32 115,
	i32 152, i32 101, i32 5, i32 40, i32 88, i32 113, i32 48, i32 4,
	i32 135, i32 157, i32 90, i32 93, i32 82, i32 36, i32 46, i32 136,
	i32 55, i32 100, i32 70, i32 64, i32 3, i32 105, i32 107, i32 9,
	i32 55, i32 134, i32 18, i32 51, i32 45, i32 64, i32 45, i32 74,
	i32 49, i32 2, i32 28, i32 18, i32 14, i32 97, i32 11, i32 113,
	i32 38, i32 53, i32 78, i32 136, i32 17, i32 27, i32 67, i32 7,
	i32 98, i32 25, i32 4, i32 84, i32 37, i32 17, i32 126, i32 96,
	i32 140, i32 127, i32 86, i32 99, i32 80, i32 39, i32 69, i32 155,
	i32 33, i32 58, i32 60, i32 106, i32 29, i32 32, i32 33, i32 38,
	i32 148, i32 108, i32 50, i32 88, i32 156, i32 97, i32 72, i32 102,
	i32 142, i32 103, i32 9, i32 56, i32 142, i32 64, i32 149, i32 92,
	i32 54, i32 73, i32 10, i32 23, i32 86, i32 22, i32 21, i32 104,
	i32 34, i32 109, i32 70, i32 48, i32 65, i32 145, i32 112, i32 1,
	i32 17, i32 109, i32 6, i32 13, i32 51, i32 83, i32 99, i32 92,
	i32 111, i32 75, i32 16, i32 55, i32 57, i32 39, i32 19, i32 73,
	i32 69, i32 141, i32 82, i32 76, i32 110, i32 16, i32 101, i32 137,
	i32 126, i32 141, i32 154, i32 78, i32 66, i32 68, i32 12, i32 83,
	i32 37, i32 43, i32 130, i32 114, i32 41, i32 5, i32 35, i32 111,
	i32 136, i32 69, i32 142, i32 153, i32 90, i32 23, i32 147, i32 19,
	i32 150, i32 98, i32 121, i32 120, i32 158, i32 127, i32 71, i32 26,
	i32 146, i32 3, i32 60, i32 10, i32 0, i32 110, i32 43, i32 105,
	i32 26, i32 157, i32 121, i32 91, i32 47, i32 22, i32 15, i32 153,
	i32 96, i32 122, i32 56, i32 137, i32 114, i32 115, i32 81, i32 59,
	i32 0, i32 100, i32 112, i32 57, i32 15, i32 81, i32 124, i32 71,
	i32 98, i32 119, i32 74, i32 130, i32 128, i32 52, i32 52, i32 143,
	i32 150, i32 56, i32 95, i32 36, i32 28, i32 20, i32 23, i32 34,
	i32 146, i32 88, i32 89, i32 32, i32 119, i32 79, i32 102, i32 129,
	i32 85, i32 68, i32 134, i32 59, i32 128, i32 42, i32 14, i32 41,
	i32 71, i32 78, i32 79, i32 39, i32 154, i32 43, i32 40, i32 94,
	i32 30, i32 131, i32 30, i32 112, i32 42, i32 139, i32 144, i32 32,
	i32 153, i32 11, i32 58, i32 62, i32 110, i32 135, i32 129, i32 120,
	i32 119, i32 13, i32 21, i32 12, i32 7, i32 138, i32 160, i32 106,
	i32 122, i32 113, i32 75, i32 47, i32 61, i32 50, i32 57, i32 6,
	i32 116, i32 121, i32 123, i32 48, i32 107, i32 19, i32 82, i32 155,
	i32 131, i32 109, i32 123, i32 62, i32 4, i32 126, i32 31, i32 54,
	i32 29, i32 133, i32 77, i32 150, i32 10, i32 44, i32 120, i32 0,
	i32 148, i32 90, i32 114, i32 137, i32 74, i32 66, i32 143, i32 67,
	i32 124, i32 36, i32 28
], align 16

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 8

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 8

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 u0x0000000000000000, ; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 8

; Functions

; Function attributes: memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 8, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 16

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { memory(write, argmem: none, inaccessiblemem: none) "min-legal-vector-width"="0" mustprogress nofree norecurse nosync "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { noreturn "no-trapping-math"="true" nounwind "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+crc32,+cx16,+cx8,+fxsr,+mmx,+popcnt,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87" "tune-cpu"="generic" }

; Metadata
!llvm.module.flags = !{!0, !1}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!".NET for Android remotes/origin/release/9.0.1xx @ a618557d1fa38074e0256317fb17c1baee245a79"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
