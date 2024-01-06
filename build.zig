const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "macos_sdk",
        .root_source_file = .{ .path = "stub.c" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    addPaths(lib);
    b.installArtifact(lib);
}

pub fn addPaths(step: *std.Build.Step.Compile) void {
    step.addSystemFrameworkPath(.{ .cwd_relative = sdkPath("/Frameworks") });
    step.addSystemIncludePath(.{ .cwd_relative = sdkPath("/include") });
    step.addLibraryPath(.{ .cwd_relative = sdkPath("/lib") });
}

fn sdkPath(comptime suffix: []const u8) []const u8 {
    if (suffix[0] != '/') @compileError("suffix must be an absolute path");
    return comptime blk: {
        const root_dir = std.fs.path.dirname(@src().file) orelse ".";
        break :blk root_dir ++ suffix;
    };
}
