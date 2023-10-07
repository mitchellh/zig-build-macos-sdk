const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "macos-sdk",
        .root_source_file = .{ .path = "stub.c" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    try addPaths(b, lib);
    b.installArtifact(lib);
}

pub fn addPaths(b: *std.Build, step: *std.build.CompileStep) !void {
    // https://github.com/ziglang/zig/issues/17358
    if (step.target.isNative()) b.sysroot = "/";

    step.addSystemFrameworkPath(.{ .path = "Frameworks" });
    step.addSystemIncludePath(.{ .path = "include" });
    step.addLibraryPath(.{ .path = "lib" });
}
