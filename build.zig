const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    _ = b.addModule("mach-gamemode", .{
        .source_file = .{ .path = "src/main.zig" },
    });

    const test_step = b.step("test", "Run tests");
    const test_exe = b.addTest(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    test_exe.linkLibC();

    test_step.dependOn(&b.addRunArtifact(test_exe).step);
}
