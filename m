Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F824059F
	for <lists+linux-block@lfdr.de>; Mon, 10 Aug 2020 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgHJMNU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Aug 2020 08:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHJMNT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Aug 2020 08:13:19 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC377C061786
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2020 05:13:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id q9so7059860oth.5
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2020 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=w1ivgbrJu4gsu9KGUxQdIOiK4eQfS1uabAcQkR/fEac=;
        b=Hok0FDmRnSHgEYgIRL4Gii4GqaA3T9IAzokXHw+WE9CV2ePYB+7J+a9gsb5rEYd79q
         uzSYin7yVhr2wawJCW30LfR5ryxki73iXgWRjrVHmAiatqNzwbA0Iro17aE1yOH5iTBJ
         /kCFcsjBozCmxUW29tMPoiInRnJApCf9h0r8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=w1ivgbrJu4gsu9KGUxQdIOiK4eQfS1uabAcQkR/fEac=;
        b=LYqhR+KGGSsPjMDgJJe3jKH1NqpmGCGkMOVAsGCm6PKqNK4+h2C/rjJz1QqXTW/ffC
         m/yUYuiwKbaE3yQ0oTHrGMPHuGOOF5doA0Accc3lcLiHh7R20BSNshN6+d4qSNmWCKn6
         T2Vec34ZxBqapLcOESOmcd0qTPvqx8CxNj3uc8zPdMYvj41gAPzQ8CL28VKkCJDck3kz
         Qq0SCi0OF9BdXJ94Go9YMdFEYFqoy2NQIyMaqkTp9ur+sKjAZ8Tz5Lsyeg+DjyBRXzn4
         qarzu8nV+iQitfje6SRXBtAxVbMdSCBdOosP1uXeUppJBmL/islhCrBlndmqUbYw/juq
         zf9A==
X-Gm-Message-State: AOAM5309ecXX8kRYRUiH9d0/3SieTPLabQmI1RxYziU23sVcnerckdAC
        7jABGcC73Q0yTTI4+aAB/cS+HC9yqw78SVow6VKMdg==
X-Google-Smtp-Source: ABdhPJxyu3OOxEoWJ0mYUuFUkfyi6/pWiMFtS5+NUDwCqqr5KflLWIpUtHhMIxzcd7QLfiPjhEGQGHsgscWHBMMRJPU=
X-Received: by 2002:a9d:7449:: with SMTP id p9mr442147otk.360.1597061595289;
 Mon, 10 Aug 2020 05:13:15 -0700 (PDT)
From:   Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de> <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com> <227c5ba1-8a9c-3ec9-5a0f-662a4736c66f@redhat.com>
 <b3350b999d5500ddef49a25aafee2ea6@mail.gmail.com> <eec84df0-1cee-e386-c18e-73ac8e0b89a3@redhat.com>
 <e76b12c664057adb51c14bf0663bb2f7@mail.gmail.com> <b471b84f-25e9-39cb-41e0-1cc1af409a8a@redhat.com>
 <7e76e1464e794a79861ea9846e0a5370@mail.gmail.com> <053466c4-7786-38aa-012f-926b68c85c8c@redhat.com>
In-Reply-To: <053466c4-7786-38aa-012f-926b68c85c8c@redhat.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
thread-index: AQIDyhmBPqdmqCKUdNTZliBUbPkt/AI5BKetAom9APICL6c0jAMHD3TmAjtZC5MBe/Ed2QIv9leoAyMPjxIBrC+2XAGG5LXBAnT4Ng+oEQymcA==
Date:   Mon, 10 Aug 2020 17:43:11 +0530
Message-ID: <05697e72c1981838c5471e503b28dfc2@mail.gmail.com>
Subject: RE: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Paolo Bonzini <pbonzini@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> And I was talking about the above PIDS(3627) to be passed to the
> interface along with UUID.

>The cgroup exists even before the VM is started and waiting for the PID to
>appear would be racy.  The PID is *not* a representation of the VM, the
>cgroup is (or at least it's the closest thing).

>Using the PID would lead to an API that is easy to misuse.  For example say
>you have a random QEMU process that has not been placed in a cgroup, for
>whatever reason.  If someone doesn't understand that the API uses the PID
> >just as a proxy for the cgroup, they could end up classifying *all traffic
>from the host* with the VMID.  If the API uses cgroups as the fundamental
>concept instead, it's much harder to make this mistake.

Agreed:
So from the user we need to provide UUID and the cgroup associated info with
VM to the kernel interface. Is this correct?
There is no issues with UUID  passing as one of the arg.
Coming to the other cgroup associated VM here are the options which we can
send

1)openfd:
We need a utility which opens the cgroup path and pass the fd details to the
interface.
And we can use the cgroup_get_from_fd() utility to get the associated cgroup
in the kernel.
Dependent on utilty.

2)cgroupid:From the  userspace iam not sure if there is any syfs/proc/sytem
call interface which give us the cgroup id directly.
Tejun correct me if iam wrong.If there is any such interface please let me
know so that I can pass the same.


3)give the complete cgroup path associated with VM and the kernel interface
will get the associated blkcg.
The user needs to pass the path and the uuid info to the sysfs interface
provided by the fabric interface
The interface will  write the uuid info in blkcg associated with cgroup path
with the help of cgroup_get_from_path().
And there is no dependency on any utility. The user can simply pass the
details using sysfs.

Need your inputs on the same which one to use (openfd/cgroupid/path) .


Regards,
Muneendra.
