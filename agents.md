# Agent

## Context

This section provides links to documentation from installed packages. It is automatically generated and may be updated by running `bake agent:context:install`.

**Important:** Before performing any code, documentation, or analysis tasks, always read and apply the full content of any relevant documentation referenced in the following sections. These context files contain authoritative standards and best practices for documentation, code style, and project-specific workflows. **Do not proceed with any actions until you have read and incorporated the guidance from relevant context files.**

**Setup Instructions:** If the referenced files are not present or if dependencies have been updated, run `bake agent:context:install` to install the latest context files.

### agent-context

Install and manage context files from Ruby gems.

#### [Getting Started](.context/agent-context/getting-started.md)

This guide explains how to use `agent-context`, a tool for discovering and installing contextual information from Ruby gems to help AI agents.

### async

A concurrency framework for Ruby.

#### [Getting Started](.context/async/getting-started.md)

This guide shows how to add async to your project and run code asynchronously.

#### [Scheduler](.context/async/scheduler.md)

This guide gives an overview of how the scheduler is implemented.

#### [Tasks](.context/async/tasks.md)

This guide explains how asynchronous tasks work and how to use them.

#### [Best Practices](.context/async/best-practices.md)

This guide gives an overview of best practices for using Async.

#### [Debugging](.context/async/debugging.md)

This guide explains how to debug issues with programs that use Async.

#### [Thread safety](.context/async/thread-safety.md)

This guide explains thread safety in Ruby, focusing on fibers and threads, common pitfalls, and best practices to avoid problems like data corruption, race conditions, and deadlocks.

### async-container

Abstract container-based parallelism using threads and processes where appropriate.

#### [Getting Started](.context/async-container/getting-started.md)

This guide explains how to use `async-container` to build basic scalable systems.

#### [Container Policies](.context/async-container/policies.md)

This guide explains how to use policies to monitor container health and implement custom failure handling strategies.

#### [Systemd Integration](.context/async-container/systemd-integration.md)

This guide explains how to use `async-container` with systemd to manage your application as a service.

#### [Kubernetes Integration](.context/async-container/kubernetes-integration.md)

This guide explains how to use `async-container` with Kubernetes to manage your application as a containerized service.

### async-http

A HTTP client and server library.

#### [Getting Started](.context/async-http/getting-started.md)

This guide explains how to get started with `Async::HTTP`.

#### [Testing](.context/async-http/testing.md)

This guide explains how to use `Async::HTTP` clients and servers in your tests.

### async-http-cache

Standard-compliant cache for async-http.

#### [Getting Started](.context/async-http-cache/getting-started.md)

This guide explains how to get started with `async-http-cache`, a cache middleware for `Async::HTTP` clients and servers.

### async-job

An asynchronous job queue for Ruby.

#### [Getting Started](.context/async-job/getting-started.md)

This guide gives you an overview of the `async-job` gem and explains the core concepts.

#### [Inline Queue](.context/async-job/inline-queue.md)

This guide explains how to use the Inline queue to execute background jobs.

#### [Aggregate Queue](.context/async-job/aggregate-queue.md)

This guide explains how to use the Aggregate queue to reduce input latency and improve the performance of your application.

### async-job-adapter-active_job

A asynchronous job queue for Ruby on Rails.

#### [Getting Started](.context/async-job-adapter-active_job/getting-started.md)

This guide explains how to get started with the `async-job-adapter-active_job` gem.

### async-service

A service layer for Async.

#### [Getting Started](.context/async-service/getting-started.md)

This guide explains how to get started with `async-service` to create and run services in Ruby.

#### [Container Policies](.context/async-service/policies.md)

This guide explains how to configure container policies for your services and understand the default failure handling behavior.

#### [Service Architecture](.context/async-service/service-architecture.md)

This guide explains the key architectural components of `async-service` and how they work together to provide a clean separation of concerns.

#### [Best Practices](.context/async-service/best-practices.md)

This guide outlines recommended patterns and practices for building robust, maintainable services with `async-service`.

#### [Deployment](.context/async-service/deployment.md)

This guide explains how to deploy `async-service` applications using systemd and Kubernetes. We'll use a simple example service to demonstrate deployment configurations.

### bake

A replacement for rake with a simpler syntax.

#### [Getting Started](.context/bake/getting-started.md)

This guide gives a general overview of `bake` and how to use it.

#### [Command Line Interface](.context/bake/command-line-interface.md)

The `bake` command is broken up into two main functions: `list` and `call`.

#### [Project Integration](.context/bake/project-integration.md)

This guide explains how to add `bake` to a Ruby project.

#### [Gem Integration](.context/bake/gem-integration.md)

This guide explains how to add `bake` to a Ruby gem and export standardised tasks for use by other gems and projects.

#### [Input and Output](.context/bake/input-and-output.md)

`bake` has built in tasks for reading input and writing output in different formats. While this can be useful for general processing, there are some limitations, notably that rich object representations like `json` and `yaml` often don't support stream processing.

### console-adapter-rails

Adapt Rails logs and events to the console gem.

#### [Getting Started](.context/console-adapter-rails/getting-started.md)

This guide explains how to integrate the `console-adapter-rails` gem into your Rails application.

### falcon

A fast, asynchronous, rack-compatible web server.

#### [Getting Started](.context/falcon/getting-started.md)

This guide gives an overview of how to use Falcon for running Ruby web applications.

#### [Rails Integration](.context/falcon/rails-integration.md)

This guide explains how to host Rails applications with Falcon.

#### [Deployment](.context/falcon/deployment.md)

This guide explains how to deploy applications using the Falcon web server. It covers the recommended deployment methods, configuration options, and examples for different environments, including systemd and kubernetes.

#### [Performance Tuning](.context/falcon/performance-tuning.md)

This guide explains the performance characteristics of Falcon.

#### [WebSockets](.context/falcon/websockets.md)

This guide explains how to use WebSockets with Falcon.

#### [Interim Responses](.context/falcon/interim-responses.md)

This guide explains how to use interim responses in Falcon to send early hints to the client.

#### [How It Works](.context/falcon/how-it-works.md)

This guide gives an overview of how Falcon handles an incoming web request.

### falcon-rails

Easy Falcon and Rails integration.

#### [Getting Started](.context/falcon-rails/getting-started.md)

This guide explains how to get started using Falcon to host your Rails application.

#### [Job Processing](.context/falcon-rails/job-processing.md)

This guide explains how to implement background job processing with Falcon and Rails using the `async-job` gem.

#### [HTTP Streaming](.context/falcon-rails/http-streaming.md)

This guide explains how to implement HTTP response streaming with Falcon and Rails.

#### [Server-Sent Events](.context/falcon-rails/server-sent-events.md)

This guide explains how to implement Server-Sent Events with Falcon and Rails.

#### [WebSockets](.context/falcon-rails/websockets.md)

This guide explains how to implement WebSocket connections with Falcon and Rails.

#### [Real-Time Views](.context/falcon-rails/real-time-views.md)

This guide explains how to implement real-time interfaces with `Live::View`.

### io-endpoint

Provides a separation of concerns interface for IO endpoints.

#### [Getting Started](.context/io-endpoint/getting-started.md)

This guide explains how to get started with `io-endpoint`, a library that provides a separation of concerns interface for network I/O endpoints.

#### [Named Endpoints](.context/io-endpoint/named-endpoints.md)

This guide explains how to use `IO::Endpoint::NamedEndpoints` to manage multiple endpoints by name, enabling scenarios like running the same application on different protocols or ports.

### io-event

An event loop.

#### [Getting Started](.context/io-event/getting-started.md)

This guide explains how to use `io-event` for non-blocking IO.

### io-stream

Provides a generic stream wrapper for IO instances.

#### [Getting Started](.context/io-stream/getting-started.md)

This guide explains how to use `io-stream` to add efficient buffering to Ruby IO objects.

#### [High Performance IO](.context/io-stream/high-performance-io.md)

This guide explains how to achieve optimal performance when using `io-stream` by understanding and controlling flush behavior.

### metrics

Application metrics and instrumentation.

#### [Getting Started](.context/metrics/getting-started.md)

This guide explains how to use `metrics` for capturing run-time metrics.

#### [Capture](.context/metrics/capture.md)

This guide explains how to use `metrics` for exporting metric definitions from your application.

#### [Testing](.context/metrics/testing.md)

This guide explains how to write assertions in your test suite to validate `metrics` are being emitted correctly.

### protocol-http

Provides abstractions to handle HTTP protocols.

#### [Getting Started](.context/protocol-http/getting-started.md)

This guide explains how to use `protocol-http` for building abstract HTTP interfaces.

#### [Message Body](.context/protocol-http/message-body.md)

This guide explains how to work with HTTP request and response message bodies using `Protocol::HTTP::Body` classes.

#### [Headers](.context/protocol-http/headers.md)

This guide explains how to work with HTTP headers using `protocol-http`.

#### [Middleware](.context/protocol-http/middleware.md)

This guide explains how to build and use HTTP middleware with `Protocol::HTTP::Middleware`.

#### [Streaming](.context/protocol-http/streaming.md)

This guide gives an overview of how to implement streaming requests and responses.

#### [Design Overview](.context/protocol-http/design-overview.md)

This guide explains the high level design of `protocol-http` in the context of wider design patterns that can be used to implement HTTP clients and servers.

### protocol-http1

A low level implementation of the HTTP/1 protocol.

#### [Getting Started](.context/protocol-http1/getting-started.md)

This guide explains how to get started with `protocol-http1`, a low-level implementation of the HTTP/1 protocol for building HTTP clients and servers.

### protocol-http2

A low level implementation of the HTTP/2 protocol.

#### [Getting Started](.context/protocol-http2/getting-started.md)

This guide explains how to use the `protocol-http2` gem to implement a basic HTTP/2 client.

### protocol-rack

An implementation of the Rack protocol/specification.

#### [Getting Started](.context/protocol-rack/getting-started.md)

This guide explains how to get started with `protocol-rack` and integrate Rack applications with `Protocol::HTTP` servers.

#### [Request and Response Handling](.context/protocol-rack/request-response.md)

This guide explains how to work with requests and responses when bridging between Rack and `Protocol::HTTP`, covering advanced use cases and edge cases.

### protocol-websocket

A low level implementation of the WebSocket protocol.

#### [Getting Started](.context/protocol-websocket/getting-started.md)

This guide explains how to use `protocol-websocket` for implementing a websocket client and server.

#### [Extensions](.context/protocol-websocket/extensions.md)

This guide explains how to use `protocol-websocket` for implementing a websocket client and server using extensions.

### samovar

Samovar is a flexible option parser excellent support for sub-commands and help documentation.

#### [Getting Started](.context/samovar/getting-started.md)

This guide explains how to use `samovar` to build command-line tools and applications.

### traces

Application instrumentation and tracing.

#### [Getting Started](.context/traces/getting-started.md)

This guide explains how to use `traces` for tracing code execution.

#### [Context Propagation](.context/traces/context-propagation.md)

This guide explains how to propagate trace context between different execution contexts within your application using `Traces.current_context` and `Traces.with_context`.

#### [Testing](.context/traces/testing.md)

This guide explains how to test traces in your code.

#### [Capture](.context/traces/capture.md)

This guide explains how to use `traces` for exporting traces from your application. This can be used to document all possible traces.
