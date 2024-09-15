# Log
log enable -f lldb.log lldb all
log enable -f packets.log gdb-remote packets

# Android
break set -n RegisterNatives
break set -n GetMethodID
break set -n GetByteArrayElements
break set -n GetArrayLength
libart.so`art::JNI::RegisterNatives

libmmkv.so`::JNI_OnLoad(JavaVM *, void *)
libart.so`art::JNI::FindClass
libart.so`art::JNI::GetMethodID(_JNIEnv*, _jclass*, char const*, char const*)
libart.so`art::JNI::CallObjectMethod(_JNIEnv*, _jobject*, _jmethodID*, ...) + 1
libart.so`art::JNI::ExceptionOccurred(_JNIEnv*) + 1
libart.so`art::JNI::GetByteArrayElements(_JNIEnv*, _jbyteArray*, unsigned char*)
libart.so`art::JNI::ReleaseByteArrayElements(_JNIEnv*, _jbyteArray*, signed char*, int)
libart.so`art::JNI::DeleteLocalRef(_JNIEnv*, _jobject*) + 1

memory find -s Signature 0xbce58ea4 0xbce58ec4
memory find -e 0x53 0xbce58ea4 0xbce58ec4
memory find -s "\53" 0xbce58ea4 0xbce58ec4

memory read --force -b -o data.bin 0xbce57044 0xbce59554

memory find -s "GetByteArrayElements" 0xbccce000 0xbef99554

break set -a 0xb51c36a9
