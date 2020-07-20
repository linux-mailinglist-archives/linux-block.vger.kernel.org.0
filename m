Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668F5225CF1
	for <lists+linux-block@lfdr.de>; Mon, 20 Jul 2020 12:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgGTKxJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jul 2020 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgGTKxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 06:53:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE20CC061794;
        Mon, 20 Jul 2020 03:53:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p3so10137845pgh.3;
        Mon, 20 Jul 2020 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0qEaLy0Hyr3SwuDgUAydri7YBfNLnnwpux/l1PMZrXs=;
        b=DfbfY0OClpMHAFSaP+f9tqbmvr533JaX4bNcruO+IiubyumIIzF+ZR7evBBXjmuleh
         R0y0HxshhdySi25YF8SHlPQj7zmSWAFkOKx8mRVYCtJyJKV0U8uGKQMDI+mM6CX2w5+4
         anzvsNc8DC07lf+jLdDPHBl0IgiIuP7vuYGDkfIRY3kSaTCyPxv/1knuqiQlFm7rzisM
         1mOuwxynMQKshI3u02qIbMOgyrLi2cQInAdG/nxy8kNET2ktdBZ0CRpK7HTLrisYD/Kt
         Cmfl8sl+grmeBz3BLzBBu7xYzx1v0wgkdSQdeIZTua85gRztILnYxuw+ULo1+dIy+7Wk
         E6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0qEaLy0Hyr3SwuDgUAydri7YBfNLnnwpux/l1PMZrXs=;
        b=DHuSQonZ8vMoj6k7LqrTrgw9/zMjj6LM9ZbAYfFpzykwUe1wCi3CUsbuTAEvarhPGX
         Nsvb8oDdfGagFCFqbUSvQimbuCWnhKNGheElM8T2V600Xdge+I61Onkb21vraShxffL/
         6Bx5tx7tLv4hwL9lfybRGTgeSxvadmU/XuIoDSPP0pzG8sNxjTac3DHtxeQpPoZbKBNG
         wRKXnF1S6WPk5YrDJtS1KKcCY/xyrlLBQK8ZaV/c8a7VAAo0nwWqTFWOikfhHIh4kGcs
         jiQmbpL1glc0NviokDdY2UdVKnzRo1PG0G6lSEvuR1UxzHCBVFP3urqAd/FcgwB1Inrb
         W7DQ==
X-Gm-Message-State: AOAM532ijqrwstqvMeGYfEeW/1WcsLEXXXtcuDLuNOYbZiYTZU5pRNYm
        HhG05RMoH/tZravFWyQkl8ncIgzkSLtCxZ4md19xdXyteas=
X-Google-Smtp-Source: ABdhPJxSxfvZHSnPCHB3+sKTFypPPlKhNZB18FrBL+Aj0NR3DL6NzsvwlGecY4X4aL9KHFMgvGGlaG7WNOlk0joiKCQ=
X-Received: by 2002:a65:6714:: with SMTP id u20mr18262640pgf.121.1595242387927;
 Mon, 20 Jul 2020 03:53:07 -0700 (PDT)
MIME-Version: 1.0
From:   Feng Li <lifeng1519@gmail.com>
Date:   Mon, 20 Jul 2020 18:52:37 +0800
Message-ID: <CAEK8JBC+0deq-aYeq=xNsypRUkR1gZVpiHjuNjh6MugYSe42XA@mail.gmail.com>
Subject: [Question] About IO timeout and hang
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Experts,

Consider accessing a "bad" disk, if the user process submits a
'read/write' request to the kernel through libaio,
and the kernel doesn't return the IO, because the underlay disk is
bad, and IO is stuck for a long time.

When the IO is a 'read', the user-space process has its own timeout
policy, and find this IO has timeout-ed, then is it safe
to free the io buffer before IO error return?
If the user-space doesn't free the buffer and use this buffer as
another read request, for example, read from another health disk,
and if at this time the bad disk response the IO,
will the buffer be corrupted by the before 'read' request?

Could anyone help me clarify this concern?

Thanks in advance.
