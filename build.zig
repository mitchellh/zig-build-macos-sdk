const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "xcode-frameworks",
        .root_source_file = .{ .path = "stub.c" },
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.installHeadersDirectory("include", ".");
    b.installArtifact(lib);
}

pub fn addPaths(step: *std.build.CompileStep) void {
    step.addFrameworkPath(sdkPath("/Frameworks"));
    step.addSystemIncludePath(sdkPath("/include"));
    step.addLibraryPath(sdkPath("/lib"));
}

fn sdkPath(comptime suffix: []const u8) []const u8 {
    if (suffix[0] != '/') @compileError("suffix must be an absolute path");
    return comptime blk: {
        const root_dir = std.fs.path.dirname(@src().file) orelse ".";
        break :blk root_dir ++ suffix;
    };
}
