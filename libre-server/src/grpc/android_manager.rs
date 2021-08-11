#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookListModulesReq {
    #[prost(string, tag = "1")]
    pub pkg_name: ::prost::alloc::string::String,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct ModuleInfo {
    #[prost(string, tag = "1")]
    pub name: ::prost::alloc::string::String,
    #[prost(string, tag = "2")]
    pub path: ::prost::alloc::string::String,
    #[prost(uint64, tag = "3")]
    pub base_addr: u64,
    #[prost(uint64, tag = "4")]
    pub size: u64,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookListModulesResp {
    #[prost(message, repeated, tag = "1")]
    pub modules: ::prost::alloc::vec::Vec<ModuleInfo>,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookListSymbolsReq {
    #[prost(string, tag = "1")]
    pub module_name: ::prost::alloc::string::String,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookSymbolInfo {
    #[prost(string, tag = "1")]
    pub module_name: ::prost::alloc::string::String,
    #[prost(string, tag = "2")]
    pub symbol_name: ::prost::alloc::string::String,
    #[prost(uint64, tag = "3")]
    pub address: u64,
    #[prost(uint64, tag = "4")]
    pub size: u64,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookListSymbolsResp {
    #[prost(message, repeated, tag = "1")]
    pub symbols: ::prost::alloc::vec::Vec<HookSymbolInfo>,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookArg {
    #[prost(int32, tag = "1")]
    pub arg_index: i32,
    #[prost(string, tag = "2")]
    pub arg_name: ::prost::alloc::string::String,
    #[prost(string, tag = "3")]
    pub arg_type: ::prost::alloc::string::String,
    #[prost(bool, tag = "4")]
    pub hooked: bool,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookInfo {
    #[prost(string, tag = "1")]
    pub module_name: ::prost::alloc::string::String,
    #[prost(string, tag = "2")]
    pub symbol_name: ::prost::alloc::string::String,
    #[prost(message, repeated, tag = "3")]
    pub args: ::prost::alloc::vec::Vec<HookArg>,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookInfoAddReq {
    #[prost(message, optional, tag = "1")]
    pub info: ::core::option::Option<HookInfo>,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookInfoAddResp {
    #[prost(int32, tag = "1")]
    pub status: i32,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookInfoListReq {}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookInfoListResp {
    #[prost(message, repeated, tag = "1")]
    pub hooks: ::prost::alloc::vec::Vec<HookInfo>,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookServerExitReq {
    #[prost(string, tag = "1")]
    pub new_pkg_name: ::prost::alloc::string::String,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookServerExitResp {
    #[prost(string, tag = "1")]
    pub result: ::prost::alloc::string::String,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookDumpMemRangeReq {
    #[prost(uint64, tag = "1")]
    pub start: u64,
    #[prost(uint64, tag = "2")]
    pub end: u64,
    #[prost(string, tag = "3")]
    pub name: ::prost::alloc::string::String,
}
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct HookDumpMemRangeResp {
    #[prost(int32, tag = "1")]
    pub status: i32,
    #[prost(string, tag = "2")]
    pub dump_file_on_device: ::prost::alloc::string::String,
}
#[doc = r" Generated client implementations."]
pub mod android_manager_client {
    #![allow(unused_variables, dead_code, missing_docs, clippy::let_unit_value)]
    use tonic::codegen::*;
    #[derive(Debug, Clone)]
    pub struct AndroidManagerClient<T> {
        inner: tonic::client::Grpc<T>,
    }
    impl AndroidManagerClient<tonic::transport::Channel> {
        #[doc = r" Attempt to create a new client by connecting to a given endpoint."]
        pub async fn connect<D>(dst: D) -> Result<Self, tonic::transport::Error>
        where
            D: std::convert::TryInto<tonic::transport::Endpoint>,
            D::Error: Into<StdError>,
        {
            let conn = tonic::transport::Endpoint::new(dst)?.connect().await?;
            Ok(Self::new(conn))
        }
    }
    impl<T> AndroidManagerClient<T>
    where
        T: tonic::client::GrpcService<tonic::body::BoxBody>,
        T::ResponseBody: Body + Send + Sync + 'static,
        T::Error: Into<StdError>,
        <T::ResponseBody as Body>::Error: Into<StdError> + Send,
    {
        pub fn new(inner: T) -> Self {
            let inner = tonic::client::Grpc::new(inner);
            Self { inner }
        }
        pub fn with_interceptor<F>(
            inner: T,
            interceptor: F,
        ) -> AndroidManagerClient<InterceptedService<T, F>>
        where
            F: FnMut(tonic::Request<()>) -> Result<tonic::Request<()>, tonic::Status>,
            T: tonic::codegen::Service<
                http::Request<tonic::body::BoxBody>,
                Response = http::Response<
                    <T as tonic::client::GrpcService<tonic::body::BoxBody>>::ResponseBody,
                >,
            >,
            <T as tonic::codegen::Service<http::Request<tonic::body::BoxBody>>>::Error:
                Into<StdError> + Send + Sync,
        {
            AndroidManagerClient::new(InterceptedService::new(inner, interceptor))
        }
        #[doc = r" Compress requests with `gzip`."]
        #[doc = r""]
        #[doc = r" This requires the server to support it otherwise it might respond with an"]
        #[doc = r" error."]
        pub fn send_gzip(mut self) -> Self {
            self.inner = self.inner.send_gzip();
            self
        }
        #[doc = r" Enable decompressing responses with `gzip`."]
        pub fn accept_gzip(mut self) -> Self {
            self.inner = self.inner.accept_gzip();
            self
        }
        pub async fn hook_list_modules(
            &mut self,
            request: impl tonic::IntoRequest<super::HookListModulesReq>,
        ) -> Result<tonic::Response<super::HookListModulesResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path = http::uri::PathAndQuery::from_static(
                "/android_manager.AndroidManager/HookListModules",
            );
            self.inner.unary(request.into_request(), path, codec).await
        }
        pub async fn hook_list_symbols(
            &mut self,
            request: impl tonic::IntoRequest<super::HookListSymbolsReq>,
        ) -> Result<tonic::Response<super::HookListSymbolsResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path = http::uri::PathAndQuery::from_static(
                "/android_manager.AndroidManager/HookListSymbols",
            );
            self.inner.unary(request.into_request(), path, codec).await
        }
        pub async fn hook_info_add(
            &mut self,
            request: impl tonic::IntoRequest<super::HookInfoAddReq>,
        ) -> Result<tonic::Response<super::HookInfoAddResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path =
                http::uri::PathAndQuery::from_static("/android_manager.AndroidManager/HookInfoAdd");
            self.inner.unary(request.into_request(), path, codec).await
        }
        pub async fn hook_info_list(
            &mut self,
            request: impl tonic::IntoRequest<super::HookInfoListReq>,
        ) -> Result<tonic::Response<super::HookInfoListResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path = http::uri::PathAndQuery::from_static(
                "/android_manager.AndroidManager/HookInfoList",
            );
            self.inner.unary(request.into_request(), path, codec).await
        }
        pub async fn hook_server_exit(
            &mut self,
            request: impl tonic::IntoRequest<super::HookServerExitReq>,
        ) -> Result<tonic::Response<super::HookServerExitResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path = http::uri::PathAndQuery::from_static(
                "/android_manager.AndroidManager/HookServerExit",
            );
            self.inner.unary(request.into_request(), path, codec).await
        }
        pub async fn hook_dump_mem_range(
            &mut self,
            request: impl tonic::IntoRequest<super::HookDumpMemRangeReq>,
        ) -> Result<tonic::Response<super::HookDumpMemRangeResp>, tonic::Status> {
            self.inner.ready().await.map_err(|e| {
                tonic::Status::new(
                    tonic::Code::Unknown,
                    format!("Service was not ready: {}", e.into()),
                )
            })?;
            let codec = tonic::codec::ProstCodec::default();
            let path = http::uri::PathAndQuery::from_static(
                "/android_manager.AndroidManager/HookDumpMemRange",
            );
            self.inner.unary(request.into_request(), path, codec).await
        }
    }
}
#[doc = r" Generated server implementations."]
pub mod android_manager_server {
    #![allow(unused_variables, dead_code, missing_docs, clippy::let_unit_value)]
    use tonic::codegen::*;
    #[doc = "Generated trait containing gRPC methods that should be implemented for use with AndroidManagerServer."]
    #[async_trait]
    pub trait AndroidManager: Send + Sync + 'static {
        async fn hook_list_modules(
            &self,
            request: tonic::Request<super::HookListModulesReq>,
        ) -> Result<tonic::Response<super::HookListModulesResp>, tonic::Status>;
        async fn hook_list_symbols(
            &self,
            request: tonic::Request<super::HookListSymbolsReq>,
        ) -> Result<tonic::Response<super::HookListSymbolsResp>, tonic::Status>;
        async fn hook_info_add(
            &self,
            request: tonic::Request<super::HookInfoAddReq>,
        ) -> Result<tonic::Response<super::HookInfoAddResp>, tonic::Status>;
        async fn hook_info_list(
            &self,
            request: tonic::Request<super::HookInfoListReq>,
        ) -> Result<tonic::Response<super::HookInfoListResp>, tonic::Status>;
        async fn hook_server_exit(
            &self,
            request: tonic::Request<super::HookServerExitReq>,
        ) -> Result<tonic::Response<super::HookServerExitResp>, tonic::Status>;
        async fn hook_dump_mem_range(
            &self,
            request: tonic::Request<super::HookDumpMemRangeReq>,
        ) -> Result<tonic::Response<super::HookDumpMemRangeResp>, tonic::Status>;
    }
    #[derive(Debug)]
    pub struct AndroidManagerServer<T: AndroidManager> {
        inner: _Inner<T>,
        accept_compression_encodings: EnabledCompressionEncodings,
        send_compression_encodings: EnabledCompressionEncodings,
    }
    struct _Inner<T>(Arc<T>);
    impl<T: AndroidManager> AndroidManagerServer<T> {
        pub fn new(inner: T) -> Self {
            let inner = Arc::new(inner);
            let inner = _Inner(inner);
            Self {
                inner,
                accept_compression_encodings: Default::default(),
                send_compression_encodings: Default::default(),
            }
        }
        pub fn with_interceptor<F>(inner: T, interceptor: F) -> InterceptedService<Self, F>
        where
            F: FnMut(tonic::Request<()>) -> Result<tonic::Request<()>, tonic::Status>,
        {
            InterceptedService::new(Self::new(inner), interceptor)
        }
        #[doc = r" Enable decompressing requests with `gzip`."]
        pub fn accept_gzip(mut self) -> Self {
            self.accept_compression_encodings.enable_gzip();
            self
        }
        #[doc = r" Compress responses with `gzip`, if the client supports it."]
        pub fn send_gzip(mut self) -> Self {
            self.send_compression_encodings.enable_gzip();
            self
        }
    }
    impl<T, B> tonic::codegen::Service<http::Request<B>> for AndroidManagerServer<T>
    where
        T: AndroidManager,
        B: Body + Send + Sync + 'static,
        B::Error: Into<StdError> + Send + 'static,
    {
        type Response = http::Response<tonic::body::BoxBody>;
        type Error = Never;
        type Future = BoxFuture<Self::Response, Self::Error>;
        fn poll_ready(&mut self, _cx: &mut Context<'_>) -> Poll<Result<(), Self::Error>> {
            Poll::Ready(Ok(()))
        }
        fn call(&mut self, req: http::Request<B>) -> Self::Future {
            let inner = self.inner.clone();
            match req.uri().path() {
                "/android_manager.AndroidManager/HookListModules" => {
                    #[allow(non_camel_case_types)]
                    struct HookListModulesSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookListModulesReq>
                        for HookListModulesSvc<T>
                    {
                        type Response = super::HookListModulesResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookListModulesReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_list_modules(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookListModulesSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                "/android_manager.AndroidManager/HookListSymbols" => {
                    #[allow(non_camel_case_types)]
                    struct HookListSymbolsSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookListSymbolsReq>
                        for HookListSymbolsSvc<T>
                    {
                        type Response = super::HookListSymbolsResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookListSymbolsReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_list_symbols(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookListSymbolsSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                "/android_manager.AndroidManager/HookInfoAdd" => {
                    #[allow(non_camel_case_types)]
                    struct HookInfoAddSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookInfoAddReq> for HookInfoAddSvc<T> {
                        type Response = super::HookInfoAddResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookInfoAddReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_info_add(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookInfoAddSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                "/android_manager.AndroidManager/HookInfoList" => {
                    #[allow(non_camel_case_types)]
                    struct HookInfoListSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookInfoListReq> for HookInfoListSvc<T> {
                        type Response = super::HookInfoListResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookInfoListReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_info_list(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookInfoListSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                "/android_manager.AndroidManager/HookServerExit" => {
                    #[allow(non_camel_case_types)]
                    struct HookServerExitSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookServerExitReq>
                        for HookServerExitSvc<T>
                    {
                        type Response = super::HookServerExitResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookServerExitReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_server_exit(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookServerExitSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                "/android_manager.AndroidManager/HookDumpMemRange" => {
                    #[allow(non_camel_case_types)]
                    struct HookDumpMemRangeSvc<T: AndroidManager>(pub Arc<T>);
                    impl<T: AndroidManager> tonic::server::UnaryService<super::HookDumpMemRangeReq>
                        for HookDumpMemRangeSvc<T>
                    {
                        type Response = super::HookDumpMemRangeResp;
                        type Future = BoxFuture<tonic::Response<Self::Response>, tonic::Status>;
                        fn call(
                            &mut self,
                            request: tonic::Request<super::HookDumpMemRangeReq>,
                        ) -> Self::Future {
                            let inner = self.0.clone();
                            let fut = async move { (*inner).hook_dump_mem_range(request).await };
                            Box::pin(fut)
                        }
                    }
                    let accept_compression_encodings = self.accept_compression_encodings;
                    let send_compression_encodings = self.send_compression_encodings;
                    let inner = self.inner.clone();
                    let fut = async move {
                        let inner = inner.0;
                        let method = HookDumpMemRangeSvc(inner);
                        let codec = tonic::codec::ProstCodec::default();
                        let mut grpc = tonic::server::Grpc::new(codec).apply_compression_config(
                            accept_compression_encodings,
                            send_compression_encodings,
                        );
                        let res = grpc.unary(method, req).await;
                        Ok(res)
                    };
                    Box::pin(fut)
                }
                _ => Box::pin(async move {
                    Ok(http::Response::builder()
                        .status(200)
                        .header("grpc-status", "12")
                        .header("content-type", "application/grpc")
                        .body(empty_body())
                        .unwrap())
                }),
            }
        }
    }
    impl<T: AndroidManager> Clone for AndroidManagerServer<T> {
        fn clone(&self) -> Self {
            let inner = self.inner.clone();
            Self {
                inner,
                accept_compression_encodings: self.accept_compression_encodings,
                send_compression_encodings: self.send_compression_encodings,
            }
        }
    }
    impl<T: AndroidManager> Clone for _Inner<T> {
        fn clone(&self) -> Self {
            Self(self.0.clone())
        }
    }
    impl<T: std::fmt::Debug> std::fmt::Debug for _Inner<T> {
        fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
            write!(f, "{:?}", self.0)
        }
    }
    impl<T: AndroidManager> tonic::transport::NamedService for AndroidManagerServer<T> {
        const NAME: &'static str = "android_manager.AndroidManager";
    }
}
