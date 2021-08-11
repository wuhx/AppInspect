#include <jni.h>
#include <sys/types.h>
#include <riru.h>
#include <malloc.h>
#include <cstring>
#include <config.h>
#include <android/log.h>
#include <dlfcn.h>

#define APPNAME "Riru-AppInspect"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, APPNAME, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, APPNAME, __VA_ARGS__)

extern "C"
{
    // jint JNIEXPORT JNI_OnLoad (JavaVM* vm, void*);
    bool check_hook_enable(char *pkg_name);
}

typedef jint (*JNI_OnLoad_fun)(JavaVM *, char *);

static char *pkg_name = "uninited";
static JavaVM *g_vm;
static bool g_is_hook = false;
static void forkAndSpecializePre(
    JNIEnv *env, jclass clazz, jint *uid, jint *gid, jintArray *gids, jint *runtimeFlags,
    jobjectArray *rlimits, jint *mountExternal, jstring *seInfo, jstring *niceName,
    jintArray *fdsToClose, jintArray *fdsToIgnore, jboolean *is_child_zygote,
    jstring *instructionSet, jstring *appDataDir, jboolean *isTopApp, jobjectArray *pkgDataInfoList,
    jobjectArray *whitelistedDataInfoList, jboolean *bindMountAppDataDirs, jboolean *bindMountAppStorageDirs)
{
    // Called "before" com_android_internal_os_Zygote_nativeForkAndSpecialize in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp
    // Parameters are pointers, you can change the value of them if you want
    // Some parameters are not exist is older Android versions, in this case, they are null or 0
    const char *name = env->GetStringUTFChars(*niceName, 0);
    pkg_name = (char *)name;
    LOGD("[%s] forkAndSpecializePre",pkg_name);
}

static bool is64()
{
    return sizeof(void *) == 8;
}
static char const *get_server_so()
{
    if (is64())
    {
        return "/data/local/tmp/libre_server.so";
    }
    else
    {
        return "/data/local/tmp/libre_server32.so";
    }
}


static void dlopen_so(const char *so_name)
{
    auto handle = dlopen(so_name, RTLD_NOW);
    LOGD("[%s] dlopen %s result! %p", pkg_name, so_name, handle);

    if (handle)
    {
        LOGD( "[%s] load %s successful! %p", pkg_name, so_name, handle);
        JNI_OnLoad_fun onload = (JNI_OnLoad_fun)dlsym(handle, "JNI_OnLoad");
        LOGD("[%s] dlsym JNI_OnLoad succ!:%p", pkg_name, onload);
        onload(g_vm, pkg_name);
    }
}

static void forkAndSpecializePost(JNIEnv *env, jclass clazz, jint res)
{
    LOGD("[%s] forkAndSpecializePost",pkg_name);
    // Called "after" com_android_internal_os_Zygote_nativeForkAndSpecialize in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp
    // "res" is the return value of com_android_internal_os_Zygote_nativeForkAndSpecialize
    env->GetJavaVM(&g_vm);

    bool is_hook = check_hook_enable(pkg_name);
    LOGD("forkAndSpecializePost: check_hook_enable result %d", is_hook);
    if (is_hook ) {
        // JNI_OnLoad(g_vm,pkg_name);
        // dlopen_so(get_server_so());
        dlopen_so("libre_server.so");
    }
                

    if (res == 0)
    {
        // In app process

        // When unload allowed is true, the module will be unloaded (dlclose) by Riru
        // If this modules has hooks installed, DONOT set it to true, or there will be SIGSEGV
        // This value will be automatically reset to false before the "pre" function is called
        // riru_set_unload_allowed(true);
    }
    else
    {
        // In zygote process
    }
}

static void specializeAppProcessPre(
    JNIEnv *env, jclass clazz, jint *uid, jint *gid, jintArray *gids, jint *runtimeFlags,
    jobjectArray *rlimits, jint *mountExternal, jstring *seInfo, jstring *niceName,
    jboolean *startChildZygote, jstring *instructionSet, jstring *appDataDir,
    jboolean *isTopApp, jobjectArray *pkgDataInfoList, jobjectArray *whitelistedDataInfoList,
    jboolean *bindMountAppDataDirs, jboolean *bindMountAppStorageDirs)
{
   LOGD("[%s] specializeAppProcessPre",pkg_name);

    // Called "before" com_android_internal_os_Zygote_nativeSpecializeAppProcess in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp
    // Parameters are pointers, you can change the value of them if you want
    // Some parameters are not exist is older Android versions, in this case, they are null or 0
}

static void specializeAppProcessPost(
    JNIEnv *env, jclass clazz)
{
    LOGD("[%s] specializeAppProcessPost", pkg_name);   
    // Called "after" com_android_internal_os_Zygote_nativeSpecializeAppProcess in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp

    // When unload allowed is true, the module will be unloaded (dlclose) by Riru
    // If this modules has hooks installed, DONOT set it to true, or there will be SIGSEGV
    // This value will be automatically reset to false before the "pre" function is called
    // riru_set_unload_allowed(true);
}

static void forkSystemServerPre(
    JNIEnv *env, jclass clazz, uid_t *uid, gid_t *gid, jintArray *gids, jint *runtimeFlags,
    jobjectArray *rlimits, jlong *permittedCapabilities, jlong *effectiveCapabilities)
{
    LOGD("[%s] forkSystemServerPre", pkg_name);   
     // Called "before" com_android_internal_os_Zygote_forkSystemServer in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp
    // Parameters are pointers, you can change the value of them if you want
    // Some parameters are not exist is older Android versions, in this case, they are null or 0
}

static void forkSystemServerPost(JNIEnv *env, jclass clazz, jint res)
{
    // Called "after" com_android_internal_os_Zygote_forkSystemServer in frameworks/base/core/jni/com_android_internal_os_Zygote.cpp
    LOGD("[%s] forkSystemServerPost", pkg_name);
    if (res == 0)
    {
        // In system server process
    }
    else
    {
        // In zygote process
    }
}


static void onModuleLoaded()
{
    LOGD("[%s] onModuleLoaded", pkg_name);



    // Called when this library is loaded and "hidden" by Riru (see Riru's hide.cpp)

    // If you want to use threads, start them here rather than the constructors
    // __attribute__((constructor)) or constructors of static variables,
    // or the "hide" will cause SIGSEGV
}

extern "C"
{

    int riru_api_version;
    const char *riru_magisk_module_path = nullptr;
    int *riru_allow_unload = nullptr;

    static auto module = RiruVersionedModuleInfo{
        .moduleApiVersion = riru::moduleApiVersion,
        .moduleInfo = RiruModuleInfo{
            .supportHide = true,
            .version = riru::moduleVersionCode,
            .versionName = riru::moduleVersionName,
            .onModuleLoaded = onModuleLoaded,
            .forkAndSpecializePre = forkAndSpecializePre,
            .forkAndSpecializePost = forkAndSpecializePost,
            .forkSystemServerPre = forkSystemServerPre,
            .forkSystemServerPost = forkSystemServerPost,
            .specializeAppProcessPre = specializeAppProcessPre,
            .specializeAppProcessPost = specializeAppProcessPost}};

    RiruVersionedModuleInfo *init(Riru *riru)
    {
        auto core_max_api_version = riru->riruApiVersion;
        riru_api_version = core_max_api_version <= riru::moduleApiVersion ? core_max_api_version : riru::moduleApiVersion;
        module.moduleApiVersion = riru_api_version;

        riru_magisk_module_path = strdup(riru->magiskModulePath);
        if (riru_api_version >= 25)
        {
            riru_allow_unload = riru->allowUnload;
        }
        return &module;
    }
}
